import threading
import socket
import psycopg2
import os
import gzip
import shutil

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="1234"
)
cur = conn.cursor()

host = "127.0.0.1"
port = 8383

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((host, port))
server.listen()

clients = []

def handle(client):
    while True:
        try:
            client.send(':'.encode('ascii'))
            user_name = client.recv(1024).decode('ascii')
            client.send('.'.encode('ascii'))
            choice = client.recv(1024).decode('ascii')
            if choice == "UP":
                upload(client, user_name)  
            else:
                download(client, user_name)
        except:
            clients.remove(client)
            client.close()
            break

def receive():
    while True:
        client, address = server.accept()
        clients.append(client)
        print(f"Connected with {str(address)}")
        client.send('Connected to the server !!'.encode('ascii'))

        thread = threading.Thread(target=handle, args=(client,))
        thread.start()

def upload(client, user_name):
    client.send('..'.encode('ascii'))
    path = client.recv(1024).decode('ascii')
    client.send('...'.encode('ascii'))
    filename = client.recv(1024).decode('ascii')
    if os.path.exists(path):
        output_file = f"{filename}.gz"
        compress(path, output_file)
    else:
        client.send('file doesnt exist'.encode('ascii'))
        return
    file_data = open(output_file, 'rb').read()
    cur.execute("INSERT INTO files(user_name, file_name, file_data) " +
                "VALUES (%s, %s, %s)",
                (user_name, output_file, psycopg2.Binary(file_data)))  
    conn.commit()
    client.send('File uploaded successfully'.encode('ascii'))

def download(client, user_name):
    client.send('...'.encode('ascii'))
    file_name = client.recv(1024).decode('ascii')
    cmd = f"SELECT file_data, file_name FROM files WHERE file_name='{file_name}.gz';"
    cur.execute(cmd)
    result = cur.fetchone()
    if result is None:
        client.send('File not found'.encode('ascii'))
    else:
        file_data, filename = result
        with open(filename, 'wb') as file:
            file.write(file_data)
        output_file = f'{filename}decompressed.txt'
        decompress(filename, output_file)

        client.send('File downloaded successfully'.encode('ascii'))
        
def compress(input_file, output_file):
    with open(input_file, 'rb') as filein:
        with gzip.open(output_file, 'wb') as fileout:
            fileout.writelines(filein)
            
def decompress(input_file, output_file):
    with gzip.open(input_file, 'rb') as f_in:
     with open(output_file, 'wb') as f_out:
        shutil.copyfileobj(f_in, f_out)

print("Server is listening")
receive()

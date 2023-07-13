import socket
import threading
import psycopg2
import sys

username = input("Enter username: ")

conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="1234"
)
cur = conn.cursor()

cmd = f"SELECT username FROM auth;"
cur.execute(cmd)
results = cur.fetchone()

for result in results:
    if username == result:
        password = input("Enter your password: ")
        cm = f"SELECT password FROM auth WHERE username='{username}'"
        cur.execute(cm)
        pwd = cur.fetchone()
        if password == pwd[0]:
            print("User authenticated!!!")
        else:
            print("Wrong password")
            sys.exit()
    else:
        print("User not found")
        sys.exit()
        
choice = input("Do you want to upload (type UP) or download (type DOWN): ")
if choice == "UP":
    path = input("Enter the path of the file: ")
    
filename = input("Enter the name of the file: ")

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('127.0.0.1', 8383))

def receive():
    while True:
        try:
            message = client.recv(1024).decode('ascii')
            if message == '.':
                client.send(choice.encode('ascii'))
            elif message == '..':
                client.send(path.encode('ascii'))
            elif message == '...':
                client.send(filename.encode('ascii'))
            elif message == ':':
                client.send(username.encode('ascii'))
            else:
                print(message)
        except:
            print("An error has occurred")
            client.close()
            break

thread = threading.Thread(target=receive)
thread.start()
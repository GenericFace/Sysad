import socket
import threading
import psycopg2
import sys

try:
    conn = psycopg2.connect(
        host="localhost",
        port="3307",
        database="postgres",
        user="postgres",
        password="1234"
    )
    cur = conn.cursor()

    username = input("Enter username: ")
    password = input("Enter your password: ")

    cmd = f"SELECT username, password FROM auth WHERE username = %s"
    cur.execute(cmd, (username,))
    user_data = cur.fetchone()

    if user_data:
        db_username, db_password = user_data
        if password == db_password:
            print("User authenticated!")
        else:
            print("Wrong password")
    else:
        print("User not found")

    cur.close()
    conn.close()

except psycopg2.Error as e:
    print(f"Error connecting to PostgreSQL: {e}")
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

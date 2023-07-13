import socket
import threading

username = input("Enter username: ")

choice = input("Do you want to upload (type UP) or download (type DOWN): ")
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
                path = input("Enter the path of the file: ")
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


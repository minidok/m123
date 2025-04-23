import socket
import signal
import sys


def signal_handler(sig, frame):
    print("\nServer shutting down...")
    UdpServer.close()
    sys.exit(0)


# UDP server that receives messages from a client and prints them to the console
# Configuration for Server
portNumber = 12345
bufferSize = 1024
host = 'localhost'
# Create a UDP socket, Address family is IPv4 and socket type is UDP (SOCK_DGRAM)
UdpServer = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Register the signal handler for Ctrl-C
signal.signal(signal.SIGINT, signal_handler)

# Bind the socket to the address and port
UdpServer.bind((host, portNumber))

# Set a timeout of 5 seconds for the socket
UdpServer.settimeout(5)

print(f"Server is running on {host}:{portNumber}")
# Loop to receive messages from the client

running = True
while running:
    try:  
        # Receive data from the client
        data, addr = UdpServer.recvfrom(bufferSize)
        # Print the received message and the address of the client
        print(f"Received message: {data.decode()} from {addr}")
        print(f"Received data content in hex {data.hex()} length in Bytes: {len(data)}")
        # Send a response back to the client
        UdpServer.sendto(b"Mitteilung angekommen", addr)
    except socket.timeout:
        # Handle the timeout and continue listening
        print("Socket timed out. Waiting for the next message...")
    except Exception as e:
        print(f"An error has been catched Exception: {e}")

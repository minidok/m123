
import socket

msgFromClient       = "Hello UDP Server"
bytesToSend         = str.encode(msgFromClient)

serverAddressPort   = ("127.0.0.1", 12345)
bufferSize          = 1024
 
# Create a UDP socket at client side
UdpClient = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
 
# Send to server using created UDP socket
UdpClient.sendto(bytesToSend, serverAddressPort)

data, addr = UdpClient.recvfrom(bufferSize)
print(f"Received message from server: {data.decode()} from {addr}")

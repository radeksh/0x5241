#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/socket.h>

#include <netinet/in.h>

#define PORT 1337
#define BUFFER_SIZE 256

int main() {

    // create a socket
    int tcp_socket;
    tcp_socket = socket(AF_INET, SOCK_STREAM, 0);
    printf("Socket created. FD %d\n", tcp_socket);

    // specify an address for the socket
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // connect to the server
    int conn_status = connect(tcp_socket, (struct sockaddr *) &server_address, sizeof(server_address));
    if (conn_status == -1) {
        printf("Connection error\n");
        exit(1);
    } else {
        printf("Connection established\n");
    }

    // receive data from the server
    char server_response[BUFFER_SIZE];
    recv(tcp_socket, &server_response, sizeof(server_response), 0);

    // print server response
    printf("Server response: %s\n", server_response);

    // close the socket
    close(tcp_socket);

    return 0;
}

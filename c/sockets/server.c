#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>

#include <netinet/in.h>

#define PORT 4
#define BUFFER_SIZE 256
#define MAX_CONNECTIONS 1

int main() {

    char welcome_message[BUFFER_SIZE] = "Welcome to the dungeon!\n";

    // create a socket
    int tcp_socket;
    tcp_socket = socket(AF_INET, SOCK_STREAM, 0);
    printf("Socket created. FD: %d\n", tcp_socket);

    // specify an address for the socket
    struct sockaddr_in server_address;
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(PORT);
    server_address.sin_addr.s_addr = INADDR_ANY;

    // bind the socket and listen for connections
    bind(tcp_socket, (struct sockaddr *) &server_address, sizeof(server_address));
    listen(tcp_socket, MAX_CONNECTIONS);
    printf("Listening on port %d \n", PORT);

    // accept a connection
    int client_socket;
    client_socket = accept(tcp_socket, NULL, NULL);
    printf("Client connected. FD: %d\n", client_socket);

    // send welcome message
    send(client_socket, welcome_message, sizeof(welcome_message), 0);

    // close the socket
    close(tcp_socket);
    printf("Socket closed. FD: %d\n", client_socket);

    return 0;
}

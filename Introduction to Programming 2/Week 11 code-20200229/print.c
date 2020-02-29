#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
   int data;
   struct Node *next;
} Node;

Node* add_element( Node *head, int element ) {
   Node *new_node;
   new_node = malloc( sizeof( Node ) );
   new_node->data = element;
   new_node->next = head;
   return new_node;
}

int length(Node *head) {
  Node *current;
  current = head;
  int count = 0;
  while( current != NULL ) {
    count++;
    current = current->next;
  }
  return count;
}
void print_list( Node *head ) {
   Node *current;
   current = head;
   while( current != NULL ) {
      if ( current == head ) {
         printf( "{ %d", current->data );
      }
      else if ( current->next != NULL ) {
         printf( ", %d", current->data );
      }
      else {
         printf( ", %d }\n", current->data );
      }
      current = current->next;
   }
}

int main() {
   Node* list_head;
   list_head = NULL;
   list_head = add_element( list_head, 3 );
   list_head = add_element( list_head, 2 );
   list_head = add_element( list_head, 1 );
   list_head = add_element( list_head, 0 );

   int len = length( list_head );
   printf( "Length is: %d\n", len );
   print_list( list_head );
}


#include "linked_list.h"

struct list_node {
   struct list_node *prev, *next;
   ll_data_t data;
};

struct list {
   struct list_node *first, *last;
};

struct list *list_create() {
    struct list *root = malloc(sizeof(struct list));
    root->first = NULL;
    root->last = NULL;
    return root;
}

size_t list_count(const struct list *list) {
    size_t counter = 0;
    struct list_node *node = list->first;
    while (node) {
        counter++;
        node = node->next;
    }
    return counter;   
}

void list_push(struct list *list, ll_data_t item_data) {
    struct list_node *node = malloc(sizeof(struct list_node));
    node->data = item_data;
    node->prev = list->last;
    node->next = NULL;
    if (list->last) {
        list->last->next = node;
    } else {
        list->first = node;
    }
    list->last = node;
}

ll_data_t list_pop(struct list *list) {
    struct list_node *node = list->last;
    if (list->first == node) {
        list->first = list->last = NULL;
    } else {
        node->prev->next = NULL;
        list->last = node->prev;
    }
    ll_data_t data = node->data;
    free(node);
    return data;
}

void list_unshift(struct list *list, ll_data_t item_data) {
    struct list_node *node = malloc(sizeof(struct list_node));
    node->data = item_data;
    node->prev = NULL;
    node->next = list->first;
    if (list->first) {
        list->first->prev = node;
    } else {
        list->last = node;
    }
    list->first = node;
}

ll_data_t list_shift(struct list *list) {
    struct list_node *node = list->first;
    if (list->last == node) {
        list->first = list->last = NULL;
    } else {
        node->next->prev = NULL;
        list->first = node->next;
    }
    ll_data_t data = node->data;
    free(node);
    return data;
}

void list_delete(struct list *list, ll_data_t data) {
    struct list_node *node = list->first;
    while (node) {
        if (node->data == data) {
            if (list->first == node) {
                list->first = node->next;
            } else {
                node->prev->next = node->next;
            }
            if (list->last == node) {
                list->last = node->prev;
            } else {
                node->next->prev = node->prev;
            }
            free(node);
            return;
        }
        node = node->next;
    }
}

void list_destroy(struct list *list) {
    struct list_node *node = list->first;
    while (node) {
        struct list_node *next = node->next;
        free(node);
        node = next;
    }
    list->first = list->last = NULL;
}

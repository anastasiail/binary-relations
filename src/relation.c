#include <stdio.h>
#include <stdlib.h>
#include "relation.h"

struct Relation* join_binary(struct Relation* r, struct Relation* s) {
        if (r == NULL || s == NULL || r->size == 0 || s->size == 0) {
            return NULL;
        }

        struct Relation* result = (struct Relation*)malloc(sizeof(struct Relation)); // result - результат композиции отношений
        
        result->size = 0;
        result->pairs = NULL;
        
        // если (a, b) и (b, c), то в result (a, c)
        for (unsigned i = 0; i < r->size; i++) {
            for (unsigned j = 0; j < s->size; j++) {
                if (r->pairs[i].second == s->pairs[j].first) {

                    struct Pair newp; // создаём (a,c)
                    newp.first = r->pairs[i].first;
                    newp.second = s->pairs[j].second;
                    
                    // чтобы не добавить дубликат
                    int in_pairs = 0;
                    for (unsigned k = 0; k < result->size; k++) {
                        if (result->pairs[k].first == newp.first && result->pairs[k].second == newp.second) {
                            in_pairs = 1;
                            break;
                        }
                    }
                    
                    if (!in_pairs) {

                        struct Pair* result_pairs = (struct Pair*)realloc(result->pairs, (result->size + 1) * sizeof(struct Pair));
                        
                        result->pairs = result_pairs;
                        result->pairs[result->size] = newp;
                        result->size++;
                    }
                }
            }
        }
        
        return result;}

void free_relation(struct Relation* r) {
    if (r != NULL) {
        free(r->pairs);
        free(r);
    }
}

void print_relation(struct Relation* r) {
    if (r == NULL || r->size == 0) {
        printf("Пар нет\n");
        return;
    }
        
    printf("{ ");
    for (unsigned i = 0; i < r->size; i++) {
        printf("(%d,%d)", r->pairs[i].first, r->pairs[i].second);
        if (i < r->size - 1) {
            printf(", ");
        }
    }
    printf(" }\n");
}


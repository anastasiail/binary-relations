#include <stdio.h>
#include <stdlib.h>
#include "relation.h"

int main() {
    // Тесты
    printf("1 тест:\n");
    struct Pair r1_pairs[] = {{1, 2}, {2, 3}, {3, 4}};
    struct Pair s1_pairs[] = {{2, 5}, {3, 6}, {4, 7}};
    
    struct Relation r1 = {r1_pairs, 3};
    struct Relation s1 = {s1_pairs, 3};
    
    struct Relation* res1 = join_binary(&r1, &s1);
    printf("R: "); print_relation(&r1);
    printf("S: "); print_relation(&s1);
    printf("RS: "); print_relation(res1);
    printf("\n");
    
    free_relation(res1);
    
    //Композиция пуста
    printf("Tест 2:\n");
    struct Pair r2_pairs[] = {{1, 2}, {3, 4}};
    struct Pair s2_pairs[] = {{5, 6}, {7, 8}};
    
    struct Relation r2 = {r2_pairs, 2};
    struct Relation s2 = {s2_pairs, 2};
    
    struct Relation* res2 = join_binary(&r2, &s2);
    printf("R: "); print_relation(&r2);
    printf("S: "); print_relation(&s2);
    printf("RS: "); print_relation(res2);
    printf("\n");
    
    free_relation(res2);
    
    //Пустые отношения
    printf("Тест 3:\n");
    struct Relation r3 = {NULL, 0};
    struct Relation s3 = {NULL, 0};
    
    struct Relation* res3 = join_binary(&r3, &s3);
    printf("R: нет пар\n");
    printf("S: нет пар\n");
    printf("RS: ");
    if (res3 == NULL) {
        printf("нет пар\n");
    } else {
        print_relation(res3);
    }
    printf("\n");
    
    // NULL указатели
    printf("Тест 4:\n");
    struct Relation* res4 = join_binary(NULL, NULL);
    printf("R: указатель на NULL\n");
    printf("S: указатель на NULL\n");
    printf("RS: ");
    if (res4 == NULL) {
        printf("нет пар\n");
    } else {
        print_relation(res4);
    }
    
    return 0;
}

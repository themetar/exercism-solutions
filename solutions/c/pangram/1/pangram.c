#include "pangram.h"

bool is_pangram(const char *sentence) {
    if (!sentence) return false;
    
    int count[26];
    
    int i = 0;

    for (i = 0; i < 26; i++) count[i] = 0;

    int index = 0;
    char c;

    while (*(sentence + index)) {
        c = *(sentence + index);

        if ('A' <= c && c <= 'Z') count[c - 'A'] += 1;
        if ('a' <= c && c <= 'z') count[c - 'a'] += 1;

        index++;
    }

    for (i = 0; i < 26; i++) if (count[i] == 0) return false;

    return true;
}
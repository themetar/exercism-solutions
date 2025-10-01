#include "scrabble_score.h"

unsigned int score(const char *word) {
    const unsigned int POINTS[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
    unsigned int total = 0;

    for (; *word != 0; word += 1) {
        const char letter = *word;
        unsigned int index = letter - (letter >= 'a' ? 'a' : 'A');
        total += POINTS[index];
    }

    return total;
}
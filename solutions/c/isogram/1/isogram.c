#include "isogram.h"

bool is_isogram(const char phrase[]) {
  if (!phrase) return false;

  for (const char *char_a = phrase; *char_a != '\0'; char_a++ ) {
    char a = tolower(*char_a);
    if (a != '-' && a != ' ') {
      for (const char *char_b = char_a + 1; *char_b != '\0'; char_b++) {
        char b = tolower(*char_b);
        if (a == b) return false;
      }
    }
  }

  return true;
}

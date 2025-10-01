#include "isogram.h"

bool is_isogram(const char phrase[]) {
  if (!phrase) return false;

  int flags = 0;

  for (const char *current = phrase; *current != '\0'; current++ ) {
    int flag = 0;

    if('a' <= *current && *current <= 'z') flag = 1 << (*current - 'a');
    if('A' <= *current && *current <= 'Z') flag = 1 << (*current - 'A');

    if (flags & flag) return false;

    flags |= flag;
  }

  return true;
}

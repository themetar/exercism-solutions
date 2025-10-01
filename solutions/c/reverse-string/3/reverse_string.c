#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
  int len = strlen(value);
  char *out = (char*)malloc((1+len)*sizeof(char)) ;

  for (int i=0; i < len; i++) {
    out[len-i-1] = value[i];
  }

  out[len] = '\0'; // null-terminate

  return out;
}

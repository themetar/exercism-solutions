#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int candidate) {
  int digit_count = (int) log10(candidate) + 1;
  
  int sum = 0;
  int candidate_copy = candidate;

  for (int i = 0; i < digit_count; i++) {
    int digit = candidate_copy % 10;
    sum += pow(digit, digit_count);
    candidate_copy /= 10;
  }

  return sum == candidate;
}

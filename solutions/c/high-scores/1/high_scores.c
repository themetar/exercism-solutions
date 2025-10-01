#include "high_scores.h"

int32_t latest(const int32_t *scores, size_t scores_len) {
  return scores[scores_len - 1];
}

int32_t personal_best(const int32_t *scores, size_t scores_len) {
  int32_t max = scores[0];

  for (size_t i = 1; i < scores_len; i++) {
    if (scores[i] > max) max = scores[i];
  }

  return max;
}

void swap(int32_t *array, int32_t a, int32_t b) {
  int32_t temp = array[a];
  array[a] = array[b];
  array[b] = temp;
}

void sort_three(int32_t *array, size_t array_len) {
  if (array_len == 1) return; // no need to sort anything, just return

  if (array[0] < array[1]) swap(array, 0, 1); // sort first two elements
  if (array_len == 2) return; // that's enough for 2-element array

  if (array[1] < array[2]) swap(array, 1, 2); // complete the sort if they are three elements
  if (array[0] < array[1]) swap(array, 0, 1);
}

size_t personal_top_three(const int32_t *scores, size_t scores_len, int32_t *output) {
  const size_t output_len = scores_len >= 3 ? 3 : scores_len;

  for (size_t i = 0; i < output_len; i++) output[i] = scores[i];  // copy first three
  sort_three(output, output_len); // sort them

  for (size_t i = 3; i < scores_len; i++) {
    if (scores[i] > output[output_len - 1]) {
      output[output_len - 1] = scores[i];
      sort_three(output, output_len);
    }
  }

  return output_len;
}

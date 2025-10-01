#ifndef HIGH_SCORES_H
#define HIGH_SCORES_H

#include <stddef.h>
#include <stdint.h>

/// Return the latest score.
int32_t latest(const int32_t *scores, size_t scores_len);

/// Return the highest score.
int32_t personal_best(const int32_t *scores, size_t scores_len);

/// Write the highest scores to `output` (in non-ascending order).
/// Return the number of scores written.
size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output);

/// Helper functions for personal_top_three
//  Swap element of index a with element with index b
void swap(int32_t *array, int32_t a, int32_t b);
//  Sort upto three elements
void sort_three(int32_t *array, size_t array_len);

#endif

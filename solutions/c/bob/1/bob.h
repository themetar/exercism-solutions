#ifndef BOB_H
#define BOB_H

#include <stdbool.h>

char *hey_bob(char *greeting);

// Returns `true` if the last non-whitespace character is '?'
bool ends_with_questonmark(char *string);

// Returns `true` if any, one character in `string` passes the `test`
bool any(char *string, bool (*test)(char));
// Returns `true` if every character in `string` passes the `test`
bool all(char *string, bool (*test)(char));

// Functions that test (return `true`) a char for
//  - not being lowercase character
//  - being uppercase
//  - beinge whitespace
bool isnot_lowercase(char);
bool is_uppercase(char);
bool is_white(char);

#endif

#include "bob.h"

bool any(char *string, bool (*test)(char)) {
  char *p = string;

  while (*p) {
    if ((test)(*p)){
      return true;
    }

    p++;
  }

  return false;
}

bool all(char *string, bool (*test)(char)) {
  char *p = string;

  while (*p) {
    if (!(test)(*p)){
      return false;
    }

    p++;
  }

  return true;
}

bool isnot_lowercase(char ch) { return !('a' <= ch && ch <= 'z'); }

bool is_uppercase(char ch) { return 'A' <= ch && ch <= 'Z'; }

bool is_white(char ch) { return ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r'; }

bool ends_with_questonmark(char *string) {
  char *p = string;
  char last_char = *p;

  while(*p) {
    if (!is_white(*p)) last_char = *p;
    p++;
  }

  return last_char == '?';
}

char *hey_bob(char *greeting) {
  bool question = ends_with_questonmark(greeting);
  bool yelling = any(greeting, &is_uppercase) && all(greeting, &isnot_lowercase);
  bool silence = all(greeting, &is_white);

  if (yelling && question)
    return "Calm down, I know what I'm doing!";

  if (yelling)
    return "Whoa, chill out!";

  if (question)
    return "Sure.";
  
  if (silence)
    return "Fine. Be that way!";

  return "Whatever.";
}

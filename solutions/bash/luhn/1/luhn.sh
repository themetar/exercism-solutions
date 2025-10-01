#!/usr/bin/env bash

# 1. Reject bad format

if [[ ! ($1 =~ ^([0-9]|[[:blank:]])+$) ]]; then
  echo "false"
  exit 0
fi

# 2. Filter digits

just_digits=""

for ((i = 0; i < ${#1}; i++)); do
  if [[ ${1:$i:1} =~ [0-9] ]]; then
    just_digits="$just_digits${1:$i:1}"
  fi
done

# 3. Reject less than 2 digits

if [[ ${#just_digits} -lt "2" ]]; then
  echo "false"
  exit 0
fi

# 4. Calculate sum according to rules

sum=0

for ((i = 0; i < ${#just_digits}; i++)); do
  n=${just_digits:$((${#just_digits} - i - 1)):1}

  if [[ $((i % 2)) -eq 1 ]]; then
    n=$(( n * 2 ))

    if [[ $n -gt 9 ]]; then
      n=$(( n - 9))
    fi
  fi

  sum=$(( sum + n))
done

# 5. Accept valid sum

if [[ $(( sum % 10 )) -eq 0 ]]; then
  echo "true"
  exit 0
fi

# 6. Else reject

echo "false"

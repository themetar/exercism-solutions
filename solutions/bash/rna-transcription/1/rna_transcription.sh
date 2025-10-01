declare -A translation
translation=( [G]=C [C]=G [T]=A [A]=U )

for ((len = ${#1}, idx = 0; idx < len; ++idx)); do
  protein=${1:idx:1}
  if [[ -z ${translation[$protein]} ]]; then
    echo "Invalid nucleotide detected."
    exit -1
  else
    out+=${translation[$protein]}
  fi
done

echo "$out"

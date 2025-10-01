alphabet=({a..z})

translate() {
  input=$1
  input_length=${#input}
  output=''

  for (( i=0; i < input_length; i++ )); do
    char_in=${input:$i:1}

    for j in {0..25}; do
      if [[ $char_in = "${alphabet[j]}" ]]; then
        output=$output${alphabet[25 - j]}
      fi
    done

    if [[ $char_in =~ [0-9] ]]; then
      output=$output$char_in
    fi
  done

  echo "$output"
}

encode() {
  translated=$(translate "$1")

  formatted=''

  length=${#translated}

  for (( i=0; i < length; i+=5 )); do
    formatted="$formatted${translated:i:5}"

    if [[ $i+5 -lt $length ]]; then
      formatted="$formatted "
    fi
  done

  echo "$formatted"  
}

main() {
  command=$1
  input=${2,,}

  case $command in
    encode) encode "$input" ;;
    decode) translate "$input" ;;
  esac
}

main "$@"

#!/bin/bash

declare -a array

while IFS= read -r line ; do
  array+=("$line")
done < $1

shuffle() {
  local i tmp size max rand

  # $RANDOM % (i+1) is biased because of the limited range of $RANDOM
  # Compensate by using a range which is a multiple of the array size.
  size=${#array[*]}
  max=$(( 32768 / size * size ))

  for ((i=size-1; i>0; i--)); do
    while (( (rand=$RANDOM) >= max )); do :; done
    rand=$(( rand % (i+1) ))
    tmp=${array[i]} array[i]=${array[rand]} array[rand]=$tmp
  done
}
shuffle

printf "%s\n" "${array[@]}"

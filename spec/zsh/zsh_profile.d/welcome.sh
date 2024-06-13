function mountains_header {
  # https://www.asciiart.eu/nature/mountains
  cat << "EOF"

          /\
         /**\
        /****\   /\
       /      \ /**\
      /  /\    /    \        /\    /\  /\      /\            /\/\/\  /\
     /  /  \  /      \      /  \/\/  \/  \  /\/  \/\  /\  /\/ / /  \/  \
    /  /    \/ /\     \    /    \ \  /    \/ /   /  \/  \/  \  /    \   \
   /  /      \/  \/\   \  /      \    /   /    \
__/__/_______/___/__\___\__________________________________________________
EOF
}

function header {
  mountains_header

  echo
  echo "$(whoami) : $(uname -n)"

  date="$(date +"%A, %B %d")"
  time="$(date +"%I:%M %p")"
  utc="$(date -u +"%H:%M UTC")"

  echo "${date} - ${time} - ${utc}"
  echo
}

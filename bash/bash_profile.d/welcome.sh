# mountain art courtesy of https://www.asciiart.eu/nature/mountains
function header {
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

  echo "$(whoami) : $(uname -n)"

  date="$(date +"%A, %B %d")"
  time="$(date +"%l:%M %p")"
  utc="$(date -u +"%H:%M UTC")"

  echo "${date} - ${time} - ${utc}"
  echo
}

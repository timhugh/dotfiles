# heroku autocomplete setup
heroku autocomplete --refresh-cache

alias stg-run="heroku run --remote stage"
alias prod-run="heroku run --remote prod"
alias stg-logs="heroku logs --remote stage --tail"
alias prod-logs="heroku logs --remote prod --tail"


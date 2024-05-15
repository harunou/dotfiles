#!/bin/zsh
# vim: set ft=sh:

# Inspired by https://github.com/lukechilds/zsh-better-npm-completion
h_get_package_json_property_object() {
  local package_json="$1"
  local property="$2"
  cat "$package_json" |
    sed -nE "/^  \"$property\": \{$/,/^  \},?$/p" | # Grab scripts object
    sed '1d;$d' |                                   # Remove first/last lines
    sed -E 's/    "([^"]+)": "(.+)",?/\1=>\2/'      # Parse into key=>value
  }

h_get_package_json_scripts_suggestions() {
  harunou np rawscripts |
    sed -E 's/(.+)=>(.+)/\1:$ \2/' |  # Parse commands into suggestions
    sed 's/\(:\)[^$]/\\&/g' |         # Escape ":" in commands
    sed 's/\(:\)$[^ ]/\\&/g'          # Escape ":$" without a space in commands
}

h_np_run_completion() {
  # Only run on `harunou np ?`
  [[ ! "$(h_no_of_harunou_args)" = "3" ]] && return

  # Look for a package.json file
  local package_json="$PWD/package.json"

  # Parse scripts in package.json
  local -a options
  options=(${(f)"$(h_get_package_json_scripts_suggestions $package_json)"})

  [[ "$#options" = 0 ]] && return 

  # Load the completions
  _describe -V 'values' options

  custom_completion=true
}

h_no_of_harunou_args() {
  echo "$#words"
}

h_harunou_default_completion() {
  compadd -- $(COMP_CWORD=$((CURRENT-1)) \
              COMP_LINE=$BUFFER \
              COMP_POINT=0 \
              harunou completion -- "${words[@]}" \
              2>/dev/null)
}

h_harunou_completion() {
  # Store custom completion status
  local custom_completion=false

  # Load custom completion commands
  case "$(_zbnc_npm_command)" in
    np)
      h_np_run_completion
      ;;
  esac

  # Fall back to default completion if we haven't done a custom one
  [[ $custom_completion = false ]] && h_default_harunou_completion
}

compdef h_harunou_completion harunou


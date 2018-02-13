#
# Defines helper functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Miltiadis Kofinas <mkofinas@gmail.com>
#

# Checks if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

# Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}

# Return the superscripted version of a number.
function make-superscript() {
  declare -A SUPERSCRIPT
  SUPERSCRIPT["0"]="⁰"
  SUPERSCRIPT["1"]="¹"
  SUPERSCRIPT["2"]="²"
  SUPERSCRIPT["3"]="³"
  SUPERSCRIPT["4"]="⁴"
  SUPERSCRIPT["5"]="⁵"
  SUPERSCRIPT["6"]="⁶"
  SUPERSCRIPT["7"]="⁷"
  SUPERSCRIPT["8"]="⁸"
  SUPERSCRIPT["9"]="⁹"

  local input_string="$1"

  local output_string=""
  if [[ $input_string =~ [0-9]\+ ]]; then
    local number_digits="${#input_string}"
    for iii in {1..${number_digits}}; do
      output_string+="${SUPERSCRIPT["$input_string[$iii]"]}"
    done
  fi
  echo "$output_string"
}

# Return the subscripted version of a number.
function make-subscript() {
  declare -A SUBSCRIPT
  SUBSCRIPT["0"]="₀"
  SUBSCRIPT["1"]="₁"
  SUBSCRIPT["2"]="₂"
  SUBSCRIPT["3"]="₃"
  SUBSCRIPT["4"]="₄"
  SUBSCRIPT["5"]="₅"
  SUBSCRIPT["6"]="₆"
  SUBSCRIPT["7"]="₇"
  SUBSCRIPT["8"]="₈"
  SUBSCRIPT["9"]="₉"

  local input_string="$1"

  local output_string=""
  if [[ $input_string =~ [0-9]\+ ]]; then
    local number_digits="${#input_string}"
    for iii in {1..${number_digits}}; do
      output_string+="${SUBSCRIPT["$input_string[$iii]"]}"
    done
  fi
  echo "$output_string"
}

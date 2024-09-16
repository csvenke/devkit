function main() {
  local search_pattern="(\.git$|package\.json$|\.sln$|\.csproj$)"
  local search_paths

  search_paths=$(find_search_paths)
  read -r -a search_paths_array <<<"$search_paths"

  local project_paths
  project_paths=$(find_project_paths "$search_pattern" "${search_paths_array[@]}")

  local selected_path
  selected_path=$(select_path "$project_paths")

  open_path "$selected_path"
}

function find_search_paths() {
  fd --type d --max-depth 1 --absolute-path . "$HOME" | sed 's@/$@@' | tr '\n' ' '
}

function find_project_paths() {
  local root_files="$1"
  shift
  local search_dir=("$@")
  fd --hidden --follow --regex "$root_files" "${search_dir[@]}" -x dirname | sort -u
}

function select_path() {
  local project_paths="$1"
  local pretty_project_paths
  pretty_project_paths=$(make_pretty_paths "$project_paths")

  echo "$pretty_project_paths" |
    fzf --ansi --border=none --info=inline |
    sed -n 's/.*(\(.*\)).*/\1/p'
}

function make_pretty_paths() {
  echo "$1" |
    awk '{ cmd = "basename " $1; cmd | getline base; close(cmd); printf "%s (%s)\n", base, $1 }' |
    awk 'BEGIN { gray="\033[90m"; blue="\033[34m"; reset="\033[0m"; folderIcon=" "; } { print blue folderIcon $1 reset " " gray ""$2"" reset }'
}

function open_path() {
  local path="$1"

  if [[ -z "$path" ]]; then
    exit 1
  fi

  cd "$path" || exit 1

  if [ -n "$VISUAL" ]; then
    "$VISUAL" .
    exit 0
  fi

  if [ -n "$EDITOR" ]; then
    "$EDITOR" .
    exit 0
  fi
}

main

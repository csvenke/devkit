function main() {
  local search_pattern="(\.git$|package\.json$|\.sln$|\.csproj$)"
  local search_paths

  search_paths=$(find_search_paths)
  read -r -a search_paths_array <<<"$search_paths"

  local project_paths
  project_paths=$(find_project_paths "$search_pattern" "${search_paths_array[@]}")

  local selected_path
  selected_path=$(select_path "$project_paths")

  if [[ -z "$selected_path" ]]; then
    exit 1
  fi

  cd "$selected_path" || exit 1

  if [ -n "$VISUAL" ]; then
    "$VISUAL" .
    exit 0
  fi

  if [ -n "$EDITOR" ]; then
    "$EDITOR" .
    exit 0
  fi
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
  local paths="$1"
  echo "$paths" | sed 's|.*/\([^/]*\)|\1 (\0)|' | fzf --ansi --border=none | sed -n 's/.*(\(.*\)).*/\1/p'
}

main

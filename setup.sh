#!/bin/sh

set -eu

repo_dir=$(CDPATH= cd "$(dirname "$0")" && pwd -P)
user_home=${HOME:?HOME must be set}

link_file() {
  source_path=$1
  destination_path=$2

  mkdir -p "$(dirname "$destination_path")"

  if [ -L "$destination_path" ]; then
    existing_target=$(readlink "$destination_path")
    if [ "$existing_target" = "$source_path" ]; then
      printf 'Already linked: %s\n' "$destination_path"
      return
    fi

    printf 'Refusing to replace symlink: %s -> %s\n' "$destination_path" "$existing_target" >&2
    exit 1
  fi

  if [ -e "$destination_path" ]; then
    printf 'Refusing to replace existing path: %s\n' "$destination_path" >&2
    exit 1
  fi

  ln -s "$source_path" "$destination_path"
  printf 'Linked: %s -> %s\n' "$destination_path" "$source_path"
}

link_file "$repo_dir/AGENTS.md" "$user_home/.agents/AGENTS.md"
link_file "$repo_dir/AGENTS.md" "$user_home/.codex/AGENTS.md"
link_file "$repo_dir/AGENTS.md" "$user_home/.claude/CLAUDE.md"

for skill_dir in "$repo_dir"/skills/*; do
  [ -f "$skill_dir/SKILL.md" ] || continue

  skill_name=${skill_dir##*/}
  link_file "$skill_dir" "$user_home/.agents/skills/$skill_name"
  link_file "$skill_dir" "$user_home/.codex/skills/$skill_name"
  link_file "$skill_dir" "$user_home/.claude/skills/$skill_name"
done

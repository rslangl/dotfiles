#!/bin/bash

DEV="$HOME"/dev
DEV_CO="$DEV"/co  # checkout other projects
DEV_RE="$DEV"/re  # reverse engineering
DEV_SW="$DEV"/sw  # main software projects
MAILS="$HOME"/mail
VM="$HOME"/vm
DOCS_ART="$HOME"/docs/art
DOCS_TECH="$HOME"/docs/tech
DOCS_SCI="$HOME"/docs/sci
DOCS_LANG="$HOME"/docs/lang
SHARE_CAST="$HOME"/share/cast   # podcasts
SHARE_SEED="$HOME"/share/seed   # torrents
SHARE_LECT="$HOME"/share/lect   # lectures

ensure_dir() {
  [[ -d "$1" ]] || mkdir -p "$1"
}

ensure_dir "$DEV"
ensure_dir "$DEV_CO"
ensure_dir "$DEV_RE"
ensure_dir "$DEV_SW"
ensure_dir "$MAILS"
ensure_dir "$VM"
ensure_dir "$DOCS_ART"
ensure_dir "$DOCS_TECH"
ensure_dir "$DOCS_SCI"
ensure_dir "$DOCS_LANG"
ensure_dir "$SHARE_CAST"
ensure_dir "$SHARE_SEED"
ensure_dir "$SHARE_LECT"


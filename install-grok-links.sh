#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
GROK_DIR="${HOME}/.grok"
SKILLS_SRC_DIR="${REPO_ROOT}/skills"
SKILLS_DST_DIR="${GROK_DIR}/skills"

if [[ ! -d "${GROK_DIR}" ]]; then
  echo "Error: ${GROK_DIR} does not exist" >&2
  exit 1
fi

# AGENTS.md (グローバル — 全プロジェクトに適用)
if [[ -f "${REPO_ROOT}/AGENTS.md" ]]; then
  ln -sfn "${REPO_ROOT}/AGENTS.md" "${GROK_DIR}/AGENTS.md"
  echo "Linked AGENTS.md -> ${GROK_DIR}/AGENTS.md"
fi

# skills (スキル単位 — ~/.grok/skills 内の既存スキルを潰さない)
if [[ -d "${SKILLS_SRC_DIR}" ]]; then
  mkdir -p "${SKILLS_DST_DIR}"
  for skill_dir in "${SKILLS_SRC_DIR}"/*/; do
    [[ -d "${skill_dir}" ]] || continue
    name="$(basename "${skill_dir}")"
    [[ -f "${skill_dir}/SKILL.md" ]] || continue
    ln -sfn "${skill_dir%/}" "${SKILLS_DST_DIR}/${name}"
    echo "Linked skills/${name} -> ${SKILLS_DST_DIR}/${name}"
  done
fi

echo "Done."

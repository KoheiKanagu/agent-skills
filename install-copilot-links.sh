#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
COPILOT_DIR="${HOME}/.copilot"
SKILLS_SRC_DIR="${REPO_ROOT}/skills"
SKILLS_DST_DIR="${COPILOT_DIR}/skills"

if [[ ! -d "${COPILOT_DIR}" ]]; then
  echo "Error: ${COPILOT_DIR} does not exist" >&2
  exit 1
fi

# AGENTS.md
if [[ -f "${REPO_ROOT}/AGENTS.md" ]]; then
  ln -sfn "${REPO_ROOT}/AGENTS.md" "${COPILOT_DIR}/copilot-instructions.md"
  echo "Linked AGENTS.md -> ${COPILOT_DIR}/copilot-instructions.md"
fi

# skills
if [[ -d "${SKILLS_SRC_DIR}" ]]; then
  ln -sfn "${SKILLS_SRC_DIR}" "${SKILLS_DST_DIR}"
  echo "Linked skills -> ${SKILLS_DST_DIR}"
fi

echo "Done."

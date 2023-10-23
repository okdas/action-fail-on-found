#!/bin/sh
set -e
set -x 

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

# Run AG to output the results to stdout
ag --vimgrep "${INPUT_PATTERN}" --ignore "${INPUT_IGNORE}" . || true

# Run it again, but this time piping the results to reviewdog
ag --vimgrep "${INPUT_PATTERN}" --ignore "${INPUT_IGNORE}" . \
  | reviewdog -efm="%f:%l:%c:%m" \
      -name="linter-name (fail-on-found)" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}

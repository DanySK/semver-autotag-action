#/bin/bash
set -e
COMMITTER=${COMMITER:-$(git log -1 --pretty=format:'%an')}
EMAIL=${EMAIL:-$(git log -1 --pretty=format:'%ae')}
if [ -z $(git config user.email) ]; then
    git config --global user.email "${EMAIL}"
fi
if [ -z $(git config user.name) ]; then
    git config --global user.name "${COMMITTER}"
fi
autotag

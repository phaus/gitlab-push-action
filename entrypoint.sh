#!/bin/sh

set -u

echo "Push $GITHUB_REPOSITORY to $GITLAB_REPOSITORY"
mkdir -p ~/.ssh
echo $SSH_PRIVATE_KEY | base64 -d > ~/.ssh/id_rsa

echo "adding host key:"
echo $GITLAB_HOST_KEY | base64 -d
echo ""
echo $GITLAB_HOST_KEY | base64 -d  > ~/.ssh/known_hosts

chmod go-w ~/
chmod 700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa

git checkout "${GITHUB_REF:11}"
git-lfs install 

git remote add gitlab $GITLAB_REPOSITORY
git push gitlab master
git push gitlab $SRC_BRANCH:$DST_BRANCH

echo "Git Version $(git describe --always --dirty --tags):"
git status

#!/bin/sh

set -u -e -x

echo "Push $GITHUB_REPOSITORY to $GITLAB_REPOSITORY"
mkdir -p ~/.ssh
echo $SSH_PRIVATE_KEY | base64 -d > ~/.ssh/id_rsa

chmod go-w ~/
chmod 700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa

ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts
ssh-keyscan -H $GITLAB_HOST >> ~/.ssh/known_hosts
echo "" >> ~/.ssh/known_hosts
echo ""
git checkout "${GITHUB_REF:11}"
git-lfs install 

git remote add gitlab $GITLAB_REPOSITORY
git push gitlab $SRC_BRANCH:$DST_BRANCH

echo "Git Version $(git describe --always --dirty --tags):"
git status

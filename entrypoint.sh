#!/bin/sh

set -u -e -x

# fix see https://stackoverflow.com/a/18079668
rm -f /dev/tty
mknod -m 666 /dev/tty c 5 0

echo "Push $GITHUB_REPOSITORY to $GITLAB_REPOSITORY"
mkdir -p ~/.ssh
echo "${SSH_PRIVATE_KEY}" | base64 -d > ~/.ssh/id_rsa

chmod go-w ~/
chmod 700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa

ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa "${GITLAB_HOST}" >> ~/.ssh/known_hosts
echo "" >> ~/.ssh/known_hosts
echo ""

ls -al ~/.ssh

ssh -v "git@${GITLAB_HOST}"

git checkout "${GITHUB_REF:11}"
git-lfs install 

git remote add gitlab $GITLAB_REPOSITORY
git push gitlab $SRC_BRANCH:$DST_BRANCH

echo "Git Version $(git describe --always --dirty --tags):"
git status

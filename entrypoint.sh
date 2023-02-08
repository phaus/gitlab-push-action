#!/bin/sh

set -u -e -x

# fix see https://stackoverflow.com/a/18079668
rm -f /dev/tty
mknod -m 666 /dev/tty c 5 0

echo "Push $GITHUB_REPOSITORY to $GITLAB_REPOSITORY"
mkdir -p /root/.ssh
echo ${SSH_PRIVATE_KEY} | base64 -d > /root/.ssh/id_rsa

chmod go-w /root/
chmod 700 /root/.ssh
chmod 0600 /root/.ssh/id_rsa

ssh -o StrictHostKeyChecking=no -v "git@${GITLAB_HOST}"

git checkout "${GITHUB_REF:11}"
git lfs install --force

git remote add gitlab $GITLAB_REPOSITORY
git push gitlab $SRC_BRANCH:$DST_BRANCH

echo "Git Version $(git describe --always --dirty --tags):"
git status

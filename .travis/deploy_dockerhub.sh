#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi

#convert name to lower-case
#CORRECT_NAME=$(echo $TRAVIS_REPO_SLUG | tr '[:upper:]' '[:lower:]')

IFS='/' read -ra GITHUB_USER <<< "$TRAVIS_REPO_SLUG"
CORRECT_NAME=${TRAVIS_REPO_SLUG/$GITHUB_USER/$DOCKER_USER}

docker build -f Dockerfile -t $CORRECT_NAME:$TAG .
docker login -u $DOCKER_USER -p $DOCKER_PASS
sudo docker push $CORRECT_NAME:$TAG

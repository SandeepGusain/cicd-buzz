#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi
CORRECT_NAME=$(echo $TRAVIS_REPO_SLUG | tr '[:upper:]' '[:lower:]')
docker build -f Dockerfile -t $CORRECT_NAME:$TAG .
docker push $CORRECT_NAME:$TAG

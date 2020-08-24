#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
if [ "$TRAVIS_BRANCH" = "master" ]; then
    TAG="latest"
else
    TAG="$TRAVIS_BRANCH"
fi
CORRECT_NAME = $TRAVIS_REPO_SLUG:$TAG | tr '[:upper:]' '[:lower:]'
docker build -f Dockerfile -t $CORRECT_NAME .
docker push $CORRECT_NAME

#!/bin/sh

BRANCH="$(git branch --show-current)"

echo "Main Branch: $BRANCH"


cp example/src/ src/
cp example/public/ public/

echo "Branch: $(git branch --show-current)" && echo "$(git log -1 --pretty=%B)" && echo "installing packages"


# yarn install
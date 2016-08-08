#!/usr/bin/env bash

rm -rf _book && gitbook build && cd _book && git init && git commit --allow-empty -m 'update book' && git checkout -b gh-pages && touch .nojekyll && git add . && git commit -am 'update book' && git push git@github.com:wmzhai/dockerbook gh-pages --force

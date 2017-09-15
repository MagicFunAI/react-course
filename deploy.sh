#!/bin/bash

gitbook build

rm -rf _book-deploy/*

mv _book/* _book-deploy/

cd _book-deploy
git add .
git commit -m'deploy'
git push

cd ..

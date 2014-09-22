#!/bin/bash

git pull

echo "Updating Sub Repos"

if [ ! -d "./drupal" ]; then
  git clone --branch 8.x http://git.drupal.org/project/drupal.git
else
  cd ./drupal
  git pull
  cd ../
fi

if [ ! -d "./pages" ]; then
  git clone --branch gh-pages git@github.com:ericduran/drupalcores.git pages
else
  cd ./pages
  git pull
  cd ..
fi

/usr/bin/ruby1.9.1 ./cores.rb > ./pages/index.html
/usr/bin/ruby1.9.1 ./companies.rb > ./pages/companies.html
/usr/bin/ruby1.9.1 ./json.rb > ./pages/data.json

cd pages
git commit -am "Update bump."
git push

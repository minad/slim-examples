#!/bin/bash
echo ===================================================
echo Updating rubygems
echo ===================================================
bundle install
bundle update
echo ===================================================
echo Generating html
echo ===================================================
mkdir -p output
for i in *.slim; do
        echo "$i -> ${i/slim/html}"
        bundle exec slimrb --trace -r slim/include -p $i > output/${i/slim/html}
done
i=$(echo *gist.rb)
echo "$i -> ${i/slim/html}"
bundle exec ruby $i > output/${i/rb/html}
echo ===================================================
echo Starting pinboard
echo ===================================================
bundle exec ruby *pinboard.rb

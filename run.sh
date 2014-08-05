#!/bin/bash
bundle install
bundle update
mkdir output
for i in *.slim; do
        bundle exec slimrb -p $i > output/${i/slim/html}
done
i=$(echo *gist.rb)
bundle exec ruby $i > output/${i/rb/html}

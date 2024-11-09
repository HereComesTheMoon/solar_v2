#!/usr/bin/env bash

# Jump to directory the shell script is placed in
cd "$(dirname "$0")"
# Jump to main solar_v2 directory
cd ..

baseURL="/" #the URL of the website e.g. https://solar.lowtechmagazine.com/
outputDir="./public/" # the directory where you export the site to.

echo "Dithering new images"
python3 utils/dither_images.py -d ./content/ --colorize --verbose

echo "Generating site"
hugo -b $baseURL --destination $outputDir --buildDrafts

echo "Calculating page sizes"
python3 utils/calculate_size.py --directory $outputDir --baseURL $baseURL --verbose

echo "Removing original media from" $outputDir
python3 utils/clean_output.py --directory $outputDir --verbose


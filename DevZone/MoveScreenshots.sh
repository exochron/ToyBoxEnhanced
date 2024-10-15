#!/bin/bash

cd Images || return

mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 06_options.jpg
mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 05_filter-source.jpg
mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 04_filter-effects.jpg
mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 03_sort.jpg
mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 02_favorites.jpg
mv "$(ls -dtr1 ../../../../Screenshots/* | tail -1)" 01_random.jpg

convert -crop 887x752+10+105 01_random.jpg 01_random.jpg
convert -crop 806x738+10+119 02_favorites.jpg 02_favorites.jpg
convert -crop 1080x738+10+119 03_sort.jpg 03_sort.jpg
convert -crop 1100x738+10+119 04_filter-effects.jpg 04_filter-effects.jpg
convert -crop 1215x791+10+119 05_filter-source.jpg 05_filter-source.jpg
convert -crop 799x400+1774+130 06_options.jpg 06_options.jpg
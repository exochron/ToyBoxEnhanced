# move most recent screenshot into ./Images with specific name
$files = ("01_random.jpg", '02_favorites.jpg', '03_sort.jpg', '04_filter-effects.jpg', '05_filter-source.jpg', '06_options.jpg')
gci ..\..\..\Screenshots\ | sort LastWriteTime |select -last $files.Count | ForEach-Object -Begin{ $i=0 } -Process { $f=$files[$i++]; move ..\..\..\Screenshots\$_ .\Images\$f -Force }

# using imagick convert to crop images
# https://imagemagick.org/script/command-line-options.php#crop
function convert
{
    docker run --rm -d -v .\Images\:/imgs dpokidov/imagemagick:latest @args
}
convert -crop 960x817+10+113 01_random.jpg 01_random.jpg
convert -crop 880x800+10+130 02_favorites.jpg 02_favorites.jpg
convert -crop 1225x800+10+130 03_sort.jpg 03_sort.jpg
convert -crop 1337x800+10+130 04_filter-effects.jpg 04_filter-effects.jpg
convert -crop 1475x800+10+130 05_filter-source.jpg 05_filter-source.jpg
convert -crop 870x895+1745+140 06_options.jpg 06_options.jpg

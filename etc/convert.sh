#!/bin/sh
##
##  Convert all fonts from DTP to Web formats
##

prefix="TypoPRO"
rm -rf web
for dir in dtp/*; do
    name=`echo "$dir" | sed -e 's;dtp/;;'`
    echo "++ $name"
    rm -rf web/$prefix-$name
    shtool mkdir -f -p -m 755 web/$prefix-$name
    for file in dtp/$name/*.ttf dtp/$name/*.otf; do
        font=`echo "$file" | sed -e 's;dtp/[^/]*/;;'`
        if [ ! -f "dtp/$name/$font" ]; then
            continue
        fi
        echo "-- converting: dtp/$name/$font"
        fontface -l -p "$prefix" -o web/$prefix-$name/ dtp/$name/$font
    done
    rm -f web/$prefix-$name/$prefix-$name.css
    cat web/$prefix-$name/*.css >x.css
    mv x.css web/$prefix-$name/$prefix-$name.css
done


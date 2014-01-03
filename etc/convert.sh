#!/bin/sh
##
##  Convert all fonts from DTP to Web formats
##

if [ ! -f etc/manifest.txt ]; then
    echo "ERROR: has to be called from top-level" 1>&2
    exit 1
fi

prefix="TypoPRO"
rm -rf web
OIFS="$IFS"; IFS="
"
for line in `cat etc/manifest.txt`; do
    IFS="$OIFS"
    font=`echo "$line" | sed -e 's; .*$;;'`
    family=`echo "$line" | sed -e 's;.*family="\([^"]*\)".*;\1;'`
    stretch=`echo "$line" | sed -e 's;^;X;' -e 's;^X.*stretch="\([^"]*\)".*;\1;' -e 's;^X.*;;'`
    echo "++ converting: $font ($family)"
    name=`echo "$font" | sed -e 's;/.*;;'`
    shtool mkdir -f -p -m 755 web/$prefix-$name
    cmd="fontface"
    cmd="$cmd -l"
    cmd="$cmd -p \"$prefix\""
    cmd="$cmd -f \"$family\""
    if [ ".$weight" != . ]; then
        cmd="$cmd -W \"$weight\""
    fi
    if [ ".$style" != . ]; then
        cmd="$cmd -Y \"$style\""
    fi
    if [ ".$stretch" != . ]; then
        cmd="$cmd -S \"$stretch\""
    fi
    if [ ".$variant" != . ]; then
        cmd="$cmd -V \"$variant\""
    fi
    cmd="$cmd -o \"web/$prefix-$name/\""
    cmd="$cmd \"dtp/$font\""
    eval $cmd
done
IFS="$OIFS"
for font in web/*; do
    name=`echo "$font" | sed -e 's;web/;;'`
    rm -f web/$name/$name.css
    cat web/$name/*.css >tmp.css
    mv tmp.css web/$name/$name.css
done
for dir in dtp/*; do
    if [ ! -d $dir ]; then
        continue
    fi
    name=`echo "$dir" | sed -e 's;dtp/;;'`
    cp dtp/$name/blurb.txt dtp/$name/license.txt web/$prefix-$name/
done


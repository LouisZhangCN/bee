#!/bin/bash

clean_arch()
{
    echo "CLEAN arch..."
    dirs=arch

    for dir in `find $dirs -mindepth 1 -maxdepth 1 -type d`
    do
        if [ "$dir" != "$dirs/arm" ]; then
            echo "CLEAN $dir"; rm -rf $dir
        fi
    done

    for dir in `find $dirs -mindepth 2 -maxdepth 2 -type d -name "mach-*" -o -name "plat-*"`
    do
        if [ "$dir" != "$dirs/arm/mach-s3c64xx" -a "$dir" != "$dirs/arm/plat-samsung" ]; then
            #echo "CLEAN $dir"
            rm -rf $dir
            dir=${dir//\//\\\/}
            sed -i "/$dir/d" $dirs/arm/Kconfig
        fi
    done

    for dir in vfp nwfpe oprofile
    do
        rm -rf $dirs/arm/$dir
    done
}

clean_out()
{
    for i in `git st | grep "OUT/"`
    do
        if [ "$i" != "#" ]; then
            rm -rf $i
            #echo $i
        fi
    done
}

show_all_dir()
{
    dir=OUT
    subdir=`find $dir -mindepth 1 -maxdepth 1 -type d`
    echo $subdir
}

auto_clean()
{
    if [ $# -gt 0 ]; then
        case $1 in
            out) clean_out;;
            arch) clean_arch;;
            list) show_all_dir;;
        esac
    fi
}

#
# main
#
auto_clean $1

exit 0

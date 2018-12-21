#!/bin/sh

#out=`make zImage`
#make zImage
make -j 8 zImage O=OUT

cp -rfv OUT/arch/arm/boot/zImage ~/project/

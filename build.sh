if ! [ -z $1 ]; then
#add preseed
chmod +w -R iso/install.amd/
gunzip iso/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F iso/install.amd/initrd
gzip iso/install.amd/initrd
chmod -w -R iso/install.amd/

#add scripts
mkdir -p iso/preseed/
cp install.sh iso/preseed/
cp -r install.d iso/preseed/
chmod +x  iso/preseed/install.d/*.sh

#md5sum
cd iso
chmod +w md5sum.txt
find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt
chmod -w md5sum.txt
cd ..

#generate iso
genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
            -no-emul-boot -boot-load-size 4 -boot-info-table \
            -o "isobuild/preseed$1.iso" iso

else
    echo "missing parameter"
fi

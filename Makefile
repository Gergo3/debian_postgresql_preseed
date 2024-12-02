

builddir = iso
scrd = $(builddir)/preseed
isoa = $(scrd)/install.sh $(scrd)/install.d $(builddir)/install.amd/initrd.gz
targetdir = isobuild

$(targetdir)/preseedn.iso : $(builddir)/md5sum.txt $(targetdir)
	#generate iso
	genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
		    -no-emul-boot -boot-load-size 4 -boot-info-table \
		    -o "isobuild/preseedn.iso" iso
	


$(targetdir) : 
	mkdir -p $@

$(builddir)/install.amd/initrd.gz : preseed.cfg
	#add preseed
	chmod +w -R iso/install.amd/
	gunzip iso/install.amd/initrd.gz
	echo preseed.cfg | cpio -H newc -o -A -F iso/install.amd/initrd
	gzip iso/install.amd/initrd
	chmod -w -R iso/install.amd/


$(scrd) :
	mkdir -p $@

$(scrd)/install.sh : install.sh $(scrd)

$(scrd)/install.d : install.d $(scrd)
	cp -r install.d $(scrd)/
	chmod +x $@/*.sh

$(builddir)/md5sum.txt : $(isoa)
	#md5sum
	cd $(builddir)
	chmod +w md5sum.txt
	find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt
	chmod -w md5sum.txt
	cd ..

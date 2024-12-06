

builddir = build/iso
scrd = $(builddir)/preseed
isoa = $(scrd)/install.sh $(scrd)/install.d $(builddir)/install.amd/initrd.gz
targetdir = isobuild
basever = 12.8.0
baseiso = build/dl/debian-$(basever)-amd64-netinst.iso

$(targetdir)/preseedn.iso : $(builddir)/md5sum.txt $(targetdir)
	#generate iso
	genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat \
		    -no-emul-boot -boot-load-size 4 -boot-info-table \
		    -o "$(targetdir)" $(builddir)

$(builddir) : $(baseiso)
	mkdir -p $(builddir)
	bsdtar -C $(builddir) -xf $(baseiso)

	
build/dl :
	mkdir -p $@

build/dloaded : build/dl
	touch $@

update : build/dl
	rm build/dl
	
$(baseiso) : build/dl build/dloaded
	cd build/dl; \
	jigdo-lite --scan . --noask https://cdimage.debian.org/debian-cd/current/amd64/jigdo-cd/debian-$(basever)-amd64-netinst.jigdo

$(targetdir) : 
	mkdir -p $@

$(builddir)/install.amd/initrd.gz : preseed.cfg $(builddir)
	#add preseed
	chmod +w -R $(builddir)/install.amd/
	gunzip $(builddir)/install.amd/initrd.gz
	echo preseed.cfg | cpio -H newc -o -A -F $(builddir)/install.amd/initrd
	gzip $(builddir)/install.amd/initrd
	chmod -w -R $(builddir)/install.amd/


$(scrd) : $(builddir)
	mkdir -p $@

$(scrd)/install.sh : install.sh $(scrd)

$(scrd)/install.d : install.d $(scrd)
	cp -r install.d $(scrd)/
	chmod +x $@/*.sh

$(builddir)/md5sum.txt : $(isoa) $(builddir)
	#md5sum
	cd $(builddir); \
	chmod +w md5sum.txt; \
	find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt; \
	chmod -w md5sum.txt

clean :
	rm -rf $(builddir)
	rm -rf build/dl
	rm build/dloaded

.PHONY : update clean

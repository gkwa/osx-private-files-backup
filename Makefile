date=$(shell date +%Y%m%d%H%M%S)
basename1=osx_private_taylor
basename:=$(basename1)_$(date)
zip=$(basename).zip
zip_static=$(basename1).zip
7Z=7z

FILE_LIST =
FILE_LIST+= ~/Library/Keychains
FILE_LIST+= ~/.ssh
FILE_LIST+= ~/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences/com.microsoft.rdc.mac.plist

upload: ~/Dropbox/Taylor
upload: $(zip)
	scp -o ConnectTimeout=10 -q $(zip) dev:
	ssh -o ConnectTimeout=10 -q dev 'cp $(zip) $(zip_static)'
	cp $(zip) ~/Dropbox/Taylor

zip: $(zip)
$(zip):
	@find $(FILE_LIST) | cpio -pamd --quiet $(basename)
	@cd $(basename) && $(7Z) a -PStre@mb0x -mx9 -tzip ../$(zip) * >/dev/null

clean:
	rm -rf $(basename1)*
	rm -f $(zip)

date=$(shell date +%Y%m%d%H%M%S)
7Z=7z

base1=osx_private_taylor
basename=$(base1)_$(date)

$(basename).7z:
	$(7Z) a -mx9 $@ ~/Library/Keychains
	$(7Z) a -mx9 $@ ~/.ssh

db: dropbox
dropbox: ~/Dropbox/Taylor/$(basename).7z
	cp $(basename).7z $<

~/Dropbox/Taylor/$(basename).7z: $(basename).7z

clean:
	rm -rf $(base1)_[0-9]*.7z

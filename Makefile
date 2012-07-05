
BASE_URL=http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central

DMG=b2g-16.0a1.en-US.mac64.dmg
OSX=$(BASE_URL)/$(DMG)

CWD=`pwd`
MOUNTPOINT=/Volumes/B2G
APP=B2G.app
DMG_APP_PATH=$(MOUNTPOINT)/$(APP)
APP_PATH=$(CWD)/$(APP)

get_dmg:
	mkdir -p ./tmp && rm -fr ./tmp/* && cd ./tmp && curl -O $(OSX)

mount_dmg:
	cd ./tmp && hdiutil mount $(DMG)

install_app: 
	cp -r $(DMG_APP_PATH) $(APP_PATH)

all: get_dmg mount_dmg install_app
	echo "Done!!"

clean:
	$(shell rm -fr ./tmp/*)

cleaner: clean
	rm -fr ./bin/$(APP)

run:
	$(APP_PATH)/Contents/MacOS/b2g -profile



BASE_URL=http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central

DMG=b2g-16.0a1.en-US.mac64.dmg
OSX=$(BASE_URL)/$(DMG)

CWD=`pwd`
MOUNTPOINT=/Volumes/B2G
APP=B2G.app
DMG_APP_PATH=$(MOUNTPOINT)/$(APP)
APP_PATH=$(CWD)/bin/$(APP)

# installation of the B2G.app on OS X
get_dmg:
	echo "Downloading latest B2G desktop build."
	mkdir -p ./tmp && rm -fr ./tmp/* && cd ./tmp && curl -O $(OSX)

mount_dmg:
	echo "Mounting disk image"
	cd ./tmp && hdiutil mount $(DMG)

install_app: 
	echo "Moving B2G app to the bin dir"
	cp -r $(DMG_APP_PATH) $(APP_PATH)

fetch_gaia:
	echo "Fetching Gaia"
	git submodule init && git sumbmodule update
	echo "Installing xulrunner dependency"
	cd ./gaia && make install-xullrunner

setup: get_dmg mount_dmg install_app clean fetch_gaia

# for running B2G
generate_profile:
	cd $(CWD)/gaia && DEBUG=1 make

run: generate_profile
	$(APP_PATH)/Contents/MacOS/b2g -profile $(CWD)/gaia/profile &
	sleep 1 && osascript -e 'tell app "B2G" to activate'


# utility 
clean:
	hdiutil unmount $(MOUNTPOINT)
	rm -fr ./tmp/*

cleaner: clean
	rm -fr ./bin/$(APP)

# from the gaia makefile
# MD5SUM = md5 -r
# SED_INPLACE_NO_SUFFIX = sed -i ''
# DOWNLOAD_CMD = curl -s -O

# update-offline-manifests:
# 	for d in `find ./apps -mindepth 1 -maxdepth 1 -type d` ;\
# 	do \
# 		rm -rf $$d/manifest.appcache ;\
# 		if [ -f $$d/manifest.webapp ] ;\
# 		ls -1 $$d ; \
# 		then \
# 			echo \\t$$d ;  \
# 			( cd $$d ; \
# 			echo "CACHE MANIFEST" > manifest.appcache ;\
# 			cat `find * -type f | sort -nfs` | $(MD5SUM) | cut -f 1 -d ' ' | sed 's/^/\#\ Version\ /' >> manifest.appcache ;\
# 			find * -type f | grep -v tools | sort >> manifest.appcache ;\
# 			$(SED_INPLACE_NO_SUFFIX) -e 's|manifest.appcache||g' manifest.appcache ;\
# 			echo "http://$(GAIA_DOMAIN)$(GAIA_PORT)/webapi.js" >> manifest.appcache ;\
# 			echo "NETWORK:" >> manifest.appcache ;\
# 			echo "http://*" >> manifest.appcache ;\
# 			echo "https://*" >> manifest.appcache ;\
# 			) ;\
# 		fi \
# 	done






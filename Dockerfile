FROM ubuntu:20.04

RUN 	apt update && \
	apt install -y xz-utils python3 python3-gpg e2fsprogs \
	android-sdk-libsparse-utils abootimg fakeroot nginx && \
	apt install git -y && \
	apt install -y tox python3-nose2 python3-mock \
	python3-coverage pep8 pyflakes3  xz-utils cpio \
	python3-six && apt install libjs-jquery-hotkeys \
	libjs-jquery-isonscreen libjs-jquery-tablesorter \
	libjs-jquery-throttle-debounce -y

RUN 	git clone https://gitlab.com/ubports/infrastructure/system-image-server.git && \
	cd system-image-server && \
	mkdir tools/keys && \
	./tools/generate-keys && \
	tox && \
	rm -f /etc/nginx/sites-enabled/default

COPY	ut-update.conf /etc/nginx/sites-enabled/
COPY	config /system-image-server/etc/config
COPY	set-server.sh /system-image-server

RUN	cd system-image-server && \	
	chmod +x  ./set-server.sh && \
	./set-server.sh

EXPOSE 80/tcp 443/tcp

ENTRYPOINT ["nginx","-g","daemon off;"]

fedora-20.tar.xz: create-base.sh fake-runtime.spec
	sudo ./create-base.sh
	(cd chroot; sudo tar cJp *;) > fedora-20.tar.xz

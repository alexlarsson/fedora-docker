rm -rf home
mkdir -p home/RPM
export HOME=`pwd`/home
cat >> home/.rpmmacros  <<_END
%_excludedocs 1
%_install_langs C:en:en_US:en_US.UTF-8
%_topdir        $HOME/RPM
_END

rpmbuild -ba fake-runtime.spec

rm -rf chroot
ROOT=`pwd`/chroot
mkdir -p $ROOT/var/lib/rpm
rpm --root $ROOT --dbpath /var/lib/rpm --initdb
rpm --root $ROOT -ivh fedora-release-20-3.noarch.rpm
rpm --root $ROOT -ivh home/RPM/RPMS/noarch/fake-runtime-0.0.1-1.fc20.noarch.rpm
yum -y --installroot=$ROOT install bash grep coreutils findutils rpm sed cpio cyrus-sasl file-libs gawk xz

# Compress cracklib
gzip -9 $ROOT/usr/share/cracklib/pw_dict.pwd

# Minimize locale-archive
localedef --prefix $ROOT --list-archive | grep -v en_US | xargs localedef --prefix $ROOT --delete-from-archive
mv $ROOT/usr/lib/locale/locale-archive $ROOT/usr/lib/locale/locale-archive.tmpl
chroot $ROOT /usr/sbin/build-locale-archive

yum -y --installroot=$ROOT clean all

touch $ROOT/sbin/init
touch $ROOT/etc/resolv.conf
mkdir -m 755 $ROOT/dev/pts
mkdir -m 755 $ROOT/dev/shm
ln -s /proc/kcore $ROOT/dev/core
ln -s /proc/self/fd $ROOT/dev/fd
ln -s /proc/self/fd/0 $ROOT/dev/stdin
ln -s /proc/self/fd/1 $ROOT/dev/stdout
ln -s /proc/self/fd/2 $ROOT/dev/stderr
#mknod -m 666 $ROOT/dev/null c 1 3 # Already exists
mknod -m 666 $ROOT/dev/zero c 1 5
mknod -m 666 $ROOT/dev/full c 1 7
mknod -m 666 $ROOT/dev/random c 1 8
mknod -m 666 $ROOT/dev/urandom c 1 9
mknod -m 666 $ROOT/dev/tty c 5 0
mknod -m 600 $ROOT/dev/console c 5 1
mknod -m 666 $ROOT/dev/ptmx c 5 2
mknod -m 600 $ROOT/dev/tty0 c 4 0
mknod -m 600 $ROOT/dev/tty1 c 4 1
mknod -m 600 $ROOT/dev/tty2 c 4 2
mknod -m 600 $ROOT/dev/tty3 c 4 3
mknod -m 600 $ROOT/dev/tty4 c 4 4
mknod -m 600 $ROOT/dev/tty5 c 4 5
mknod -m 600 $ROOT/dev/tty6 c 4 6
mknod -m 600 $ROOT/dev/tty7 c 4 7
mknod -m 600 $ROOT/dev/tty8 c 4 8
mknod -m 600 $ROOT/dev/tty9 c 4 9
chown root.tty $ROOT/dev/tty* $ROOT/dev/ptmx

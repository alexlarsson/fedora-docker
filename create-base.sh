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
rpm --root $ROOT -ivh fedora-release-19-2.noarch.rpm
rpm --root $ROOT -ivh home/RPM/RPMS/noarch/fake-runtime-0.0.1-1.fc19.noarch.rpm
yum -y --installroot=$ROOT install bash grep coreutils findutils rpm sed cpio cyrus-sasl file-libs gawk xz

# Compress cracklib
gzip -9 $ROOT/usr/share/cracklib/pw_dict.pwd

# Minimize locale-archive
localedef --prefix $ROOT --list-archive | grep -v en_US | xargs localedef --prefix $ROOT --delete-from-archive
mv $ROOT/usr/lib/locale/locale-archive $ROOT/usr/lib/locale/locale-archive.tmpl
chroot $ROOT /usr/sbin/build-locale-archive

yum -y --installroot=$ROOT clean all

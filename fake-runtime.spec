Name:		fake-runtime
Version:	0.0.1
Release:	1%{?dist}
Summary:	Fake runtime
License:	GPLv2+
BuildArch:      noarch
Provides:       kmod
Provides:       systemd = 204
Provides:       systemd-units = 204
Provides:       udev = 204

%description
This is a fake package that provides certain system runtime packages
so that we can avoid pulling them into the docker base. This is useful
because many packages make little sense in an docker image.

%prep

%build

%install
rm -rf $RPM_BUILD_ROOT

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)

%changelog
* Fri Aug 23 2013 Alexander Larsson <alexl@redhat.com> - 0.0.1-1
- Initial version


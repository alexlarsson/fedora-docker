FROM alexl/fedora-19
RUN rpm -Uvh ftp://ftp.sunet.se/pub/Linux/distributions/fedora/linux/releases/19/Everything/x86_64/os/Packages/m/mailcap-2.1.41-1.fc19.noarch.rpm 
RUN rpm -Uvh ftp://ftp.sunet.se/pub/Linux/distributions/fedora/linux/releases/19/Everything/x86_64/os/Packages/e/expat-2.1.0-5.fc19.x86_64.rpm
RUN rpm -Uvh ftp://ftp.sunet.se/pub/Linux/distributions/fedora/linux/releases/19/Everything/x86_64/os/Packages/a/apr-1.4.6-6.fc19.x86_64.rpm
RUN rpm -Uvh ftp://ftp.sunet.se/pub/Linux/distributions/fedora/linux/releases/19/Everything/x86_64/os/Packages/a/apr-util-1.4.1-8.fc19.x86_64.rpm
RUN rpm -Uvh ftp://rpmfind.net/linux/fedora/linux/updates/19/x86_64/httpd-tools-2.4.6-2.fc19.x86_64.rpm
# Nodeps to ignore fedora-logos dependecy
RUN rpm -Uvh ftp://rpmfind.net/linux/fedora/linux/updates/19/x86_64/httpd-2.4.6-2.fc19.x86_64.rpm --nodeps --excludepath=/usr/sbin/suexec
RUN echo "<html><body>Hello world</body></html>" > /var/www/html/index.html
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]


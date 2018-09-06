%global version 0.4
%{!?pgversion: %global pgversion 10}
%{!?pginstdir: %global pginstdir /usr/pgsql-10}

Summary:	Tool for dumping database creation options
Name:     pg_dumpacl%{pgversion}
Version:	%{version}
Release:	1%{?dist}
License:	BSD
Group:		Applications/Databases
Source0:	pg_dumpacl.c
Source1:	Makefile
URL:      https://github.com/dalibo/pg_dumpacl
BuildRequires:	  postgresql%{pgversion}-devel
BuildRoot:        %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires:	postgresql%{pgversion}-server
Requires(post):   %{_sbindir}/update-alternatives
Requires(postun): %{_sbindir}/update-alternatives

%description
This utility allows to dump database creation statements in a manner similar to
pg_dumpacl.

%prep
cp %{SOURCE0} ./
cp %{SOURCE1} ./

%build
PG_CONFIG=%{pginstdir}/bin/pg_config make  %{?_smp_mflags}

%install
PG_CONFIG=%{pginstdir}/bin/pg_config make  %{?_smp_mflags} install DESTDIR=%{buildroot}

%post
%{_sbindir}/update-alternatives --install %{_bindir}/pg_dumpacl pgsql-pg_dumpacl %{pginstdir}/bin/pg_dumpacl 930

%clean
rm -rf %{buildroot}

%postun
if [ "$1" -eq 0 ] ; then
	# Only remove these links if the package is completely removed from the system (vs.just being upgraded)
	%{_sbindir}/update-alternatives --remove pgsql-pg_dumpacl	%{pginstdir}/bin/pg_dumpacl
fi

%files
%{pginstdir}/bin/pg_dumpacl

%changelog

* Thu Sep 06 2018 tilkow - 0.4-1
* Wed Aug 22 2018 Étienne BERSAC <etienne.bersac@dalibo.com> - 0.3-1

- Fix options parsing.

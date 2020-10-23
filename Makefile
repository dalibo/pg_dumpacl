srcdir = .
PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
CFLAGS = -I$(shell $(PG_CONFIG) --includedir-server) $(CPPFLAGS)
include $(PGXS)
override CPPFLAGS := $(CPPFLAGS) -I$(shell $(PG_CONFIG) --includedir)
override LDFLAGS :=  $(shell $(PG_CONFIG) --ldflags) $(LDFLAGS)
override LDFLAGS_EX :=  $(shell $(PG_CONFIG) --ldflags_ex) $(LDFLAGS_EX)
override CPPFLAGS := -I$(libpq_srcdir) $(CPPFLAGS)
override LDLIBS := $(libpq_pgport) $(LDLIBS)


all: pg_dumpacl

pg_dumpacl: pg_dumpacl.o


install: all installdirs
	$(INSTALL_PROGRAM) pg_dumpacl$(X) '$(DESTDIR)$(bindir)'/pg_dumpacl$(X)

installdirs:
	$(MKDIR_P) '$(DESTDIR)$(bindir)'

uninstall:
	rm -f $(addprefix '$(DESTDIR)$(bindir)'/, pg_dump_acl$(X)

clean distclean maintainer-clean:
	rm -f pg_dumpacl pg_dumpacl.o

.PHONY: rpms
rpms:
	PGVERSION=10 docker-compose run --rm rpm
	PGVERSION=9.6 docker-compose run --rm rpm
	PGVERSION=9.5 docker-compose run --rm rpm

YUMLABS?=../yum-labs
publish:
	mkdir -p $(YUMLABS)/rpms/CentOS7-x86_64/ $(YUMLABS)/rpms/CentOS8-x86_64/
	find rpms -name "*.el7.x86_64.rpm" | xargs -tI % cp -vf % $(YUMLABS)/rpms/CentOS7-x86_64/
	find rpms -name "*.el8.x86_64.rpm" | xargs -tI % cp -vf % $(YUMLABS)/rpms/CentOS8-x86_64/
	$(MAKE) -C $(YUMLABS) push createrepos

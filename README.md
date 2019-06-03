# `pg_dumpacl` [![](https://circleci.com/gh/dalibo/pg_dumpacl.svg?style=shield)](https://circleci.com/gh/dalibo/pg_dumpacl)

A tool to dump ACL per database, based on `pg_dump`

> This tool is useful only for PostgreSQL 10 and earlier versions.
> Since PostgreSQL 11, the `--create` option of [pg_dump] will
> export the ACL privileges for the database. Thus making this 
> tool obsolete.

[pg_dump]: https://www.postgresql.org/docs/current/app-pgdump.html


``` console
$ ./pg_dumpacl -d db0
--
-- Database creation
--

CREATE DATABASE "db0" WITH TEMPLATE = template0 OWNER = "postgres";
REVOKE ALL ON DATABASE "db0" FROM PUBLIC;
REVOKE ALL ON DATABASE "db0" FROM "postgres";
GRANT ALL ON DATABASE "db0" TO "postgres";
GRANT CONNECT,TEMPORARY ON DATABASE "db0" TO PUBLIC;
GRANT CONNECT ON DATABASE "db0" TO "dba";
```


## Installation

Enable [Dalibo Labs YUM repository](http://yum.dalibo.org/labs/) and install
`pg_dumpacl10` package or the variant for the version of Postgres installed.

``` console
# yum install -y https://yum.dalibo.org/labs/dalibo-labs-1-1.noarch.rpm
# yum makecache fast
# yum search pg_dumpacl
=================== N/S matched: pg_dumpacl ================================
pg_dumpacl10.x86_64 : Tool for dumping database creation options
pg_dumpacl93.x86_64 : Tool for dumping database creation options
pg_dumpacl94.x86_64 : Tool for dumping database creation options
pg_dumpacl95.x86_64 : Tool for dumping database creation options
pg_dumpacl96.x86_64 : Tool for dumping database creation options
#
```

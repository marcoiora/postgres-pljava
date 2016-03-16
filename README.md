# postgres-pljava
[PostgreSQL](http://www.postgresql.org) server 9.4 with embedded Java ([PLJava](https://github.com/tada/pljava))

## Run server
docker run -p 5432:5432 xxbedy/postgres-pljava

## Run client - plsql
```Bash
docker run -ti xxbedy/postgres-pljava psql -U postgres
```

optionally run with -h parameter to setup host if server runs on different machine than client

```Bash
docker run -ti xxbedy/postgres-pljava psql -U postgres -h 10.211.55.28
```
## Execute examples from [PLJava](https://github.com/tada/pljava/tree/master/pljava-examples)
```SQL
 SELECT javatest.randomInts(10);
 SELECT javatest.listSupers();
 ...
```

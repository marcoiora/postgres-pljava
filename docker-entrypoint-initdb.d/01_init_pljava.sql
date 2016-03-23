SELECT version();
SET pljava.libjvm_location TO '/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/libjvm.so';
ALTER DATABASE postgres SET pljava.libjvm_location FROM CURRENT;
CREATE EXTENSION pljava;
SELECT sqlj.install_jar('file:///pljava/pljava-examples/target/pljava-examples-1.5.0-BETA3.jar', 'examples', true);
SHOW search_path;
SELECT sqlj.get_classpath('javatest');
SELECT sqlj.set_classpath('javatest', 'examples');
SELECT sqlj.get_classpath('javatest');
SELECT javatest.java_addone(3);
SELECT array_agg(java_getsystemproperty(p)) FROM (values ('org.postgresql.pljava.version'), ('org.postgresql.version'), ('java.version'), ('os.name'), ('os.arch') ) AS props(p);

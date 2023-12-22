mkdir -p units
# curl -O https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-core/1.2.1/hadoop-core-1.2.1.jar
javac -classpath hadoop-core-1.2.1.jar -target 8 -source 8 -d units ProcessUnits.java
jar -cvf units.jar -C units/ .

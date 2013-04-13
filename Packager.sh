sbt package
cp target/scala-2.9.2/default-8af382_2.9.2-0.1-SNAPSHOT.jar runJar.jar 
hadoop fs -rmr output
hadoop fs -rmr osx64

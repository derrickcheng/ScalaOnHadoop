ScalaOnHadoop
=============
This is an sbt project.

This is how you run BIDMat on icluster
`./RunBIDMat.sh` <-- the  variables for this should work for any any Berkeley icluster cs294 account.

This includes an example called BIDMatExample.scala which simply takes in two BIDMat matrices in text form, converts them to FMat's, then adds them together, and writes it out in text format again.

In order to serialize FMat's and other Mats, it takes advantage of the MatIO.scala class which lives in https://github.com/derrickcheng/BIDMatWithHDFS. An up to date jar of BIDMatWithHDFS is located here: lib/BIDMatWithHDFS.jar. 

If you want to write your own MapReduce job that runs BIDMat and Scala, make another file and format it liek BIDMatExample.scala then:
`sbt package` #the jar then the jar will be located in the target directory somewhere. so find it and then use that jar in `RunBIDMat.sh` instead of runJar.jar which holds the sbt packaged version of BIDMatExample.scala code.  

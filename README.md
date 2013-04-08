ScalaOnHadoop
=============
This is an sbt project.

This is how you run BIDMat on icluster
`hadoop fs -put input input` <-- load the input into your hadoop directory
`./RunBIDMat.sh` <-- the  variables for this should work for any any Berkeley icluster cs294 account.

This runs a mapreduce job written in scala called BIDMatExample.scala which simply takes in two BIDMat matrices in text form, converts them to FMat's, then adds them together, and writes it out in text format again.

In order to serialize FMat's and other Mats, it takes advantage of the MatIO.scala class which lives in https://github.com/derrickcheng/BIDMatWithHDFS. An up to date jar of BIDMatWithHDFS is located here: `lib/BIDMatWithHDFS.jar`. MatIO is basically a container for storing a BIDMat Mat that is serializable and thus can be the output and input type of a Reduce and Mapper job. Currently, MatIO in BIDMatWithHDFS only supports a few Mat types, feel free to add more of them it should only be a line change to add each new type.

to verify that `./RunBIDMat.sh` is working on your icluster account with `input` as your input, run:
`hadoop fs -cat output/part-r-00000`
The output should look like:
`5.0	7.0	9.0	11.0	`
since it just added `hadoop fs -cat input/mat1.txt` to `hadoop fs -cat input/mat2.txt`


If you want to write your own MapReduce job that runs BIDMat and Scala, make another file and format it like BIDMatExample.scala then:
`sbt package` <--the jar then will be located in the target directory somewhere. so find it and then use that jar in `./RunBIDMat.sh` instead of runJar.jar. runJar.jar currently holds the sbt packaged version of BIDMatExample.scala code.  

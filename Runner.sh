#!/bin/bash
export BIDMAT_ROOT="/Users/dcheng090/Software/BIDMat" #MODIFY THIS WITH BIDMAT LOCATION
export SCALA_ROOT="/Users/dcheng090/DmgFiles/scala-2.9.2/lib" #MODIFY THIS WITH SCALA LOCATION

# This is only needed/works on Linux

export JCUDA_VERSION="0.4.2"
export JCUDA_LIBDIR=${BIDMAT_ROOT}/lib
export LIBDIR=${BIDMAT_ROOT}/lib

export BIDMAT_LIBS="${BIDMAT_ROOT}/BIDMat.jar:${LIBDIR}/ptplot.jar:${LIBDIR}/ptplotapplication.jar:${LIBDIR}/jhdf5.jar"
export JCUDA_LIBS="${JCUDA_LIBDIR}/jcuda-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcublas-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcufft-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcurand-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcusparse-${JCUDA_VERSION}.jar"
export MATIO_LIBS="Lib/BIDMatWithHDFS.jar" #MODIFY THIS WITH BIDMatWithHDFS jar
export HADOOP_LIBS="/usr/local/Cellar/hadoop/1.0.4/libexec/hadoop-core-1.0.4.jar:/usr/local/Cellar/hadoop/1.0.4/libexec/lib/commons-logging-1.1.1.jar" #MODIFY THIS WITH HADOOP LIBS
export SCALA_LIBS="${SCALA_ROOT}/jline.jar:${SCALA_ROOT}/scala-compiler.jar:${SCALA_ROOT}/scala-library.jar:${SCALA_ROOT}/scalap.jar:${SCALA_ROOT}/scalacheck.jar:${SCALA_ROOT}/scala-dbc.jar:${SCALA_ROOT}/scala-partest.jar:${SCALA_ROOT}/scala-swing.jar"

export ALL_LIBS="${SCALA_LIBS}:${MATIO_LIBS}:${HADOOP_LIBS}:${BIDMAT_LIBS}:${JCUDA_LIBS}:${JAVA_HOME}/lib/tools.jar"
#echo $ALL_LIBS

#export LD_LIBRARY_PATH="${BIDMAT_ROOT}/lib/linux64:${BIDMAT_ROOT}/lib/linux64/JCUDA4.2:/usr/local/cuda-4.2/lib64:${LD_LIBRARY_PATH}" 

export HADOOP_USER_CLASSPATH_FIRST="true"
export HADOOP_CLASSPATH="${ALL_LIBS}"

echo $HADOOP_CLASSPATH

hadoop jar runJar.jar "WordCount" input output

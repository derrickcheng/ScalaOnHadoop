#!/bin/bash
export BIDMAT_ROOT="/home/ff/cs294/cs294-1/code/BIDMat" #MODIFY THIS WITH BIDMAT LOCATION
export SCALA_ROOT="/home/ff/cs294/cs294-1/code/scala-2.9.2/lib" #MODIFY THIS WITH SCALA LOCATION

# This is only needed/works on Linux

export JCUDA_VERSION="0.4.2"
export JCUDA_LIBDIR=${BIDMAT_ROOT}/lib
export LIBDIR=${BIDMAT_ROOT}/lib

export BIDMAT_LIBS="${BIDMAT_ROOT}/BIDMat.jar:${LIBDIR}/ptplot.jar:${LIBDIR}/ptplotapplication.jar:${LIBDIR}/jhdf5.jar"
export JCUDA_LIBS="${JCUDA_LIBDIR}/jcuda-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcublas-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcufft-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcurand-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcusparse-${JCUDA_VERSION}.jar"
export MATIO_LIBS="lib/BIDMatWithHDFS.jar" #MODIFY THIS WITH BIDMatWithHDFS jar
export HADOOP_LIBS="/home/aa/projects/hadoop/hadoop/hadoop-core-1.0.3.jar:/home/aa/projects/hadoop/hadoop/lib/commons-logging-1.1.1.jar" #MODIFY THIS WITH HADOOP LIBS
export SCALA_LIBS="${SCALA_ROOT}/jline.jar:${SCALA_ROOT}/scala-compiler.jar:${SCALA_ROOT}/scala-library.jar:${SCALA_ROOT}/scalap.jar:${SCALA_ROOT}/scalacheck.jar:${SCALA_ROOT}/scala-dbc.jar:${SCALA_ROOT}/scala-partest.jar:${SCALA_ROOT}/scala-swing.jar"


export LD_LIBRARY_PATH="${BIDMAT_ROOT}/lib/linux64:${BIDMAT_ROOT}/lib/linux64/JCUDA4.2" #:/usr/local/cuda-4.2/lib64:${LD_LIBRARY_PATH}"

export ALL_LIBS="${SCALA_LIBS}:${MATIO_LIBS}:${HADOOP_LIBS}:${BIDMAT_LIBS}:${JCUDA_LIBS}:${JAVA_HOME}/lib/tools.jar"

#export HADOOP_USER_CLASSPATH_FIRST="true"
export HADOOP_CLASSPATH="${ALL_LIBS}"
#export HADOOP_CLASSPATH=lib/scala-library.jar:lib/BIDMat.jar:lib/jline-2.9.2.jar
export LIB_JARS=`echo ${HADOOP_CLASSPATH} | sed s/:/,/g`

if [ `uname` = "Darwin" ]; then
        hadoop fs -put ${BIDMAT_ROOT}/lib/osx64/ osx64
        export FILES="osx64/HDF5_Copyright.html,osx64/JCUDA5.0,osx64/JCUDA_Copyright.txt,osx64/libbidmatmkl.jnilib,osx64/libhdf4.settings,osx64/libhdf5.settings,osx64/libiomp5.dylib,osx64/libjhdf.jnilib,osx64/libjhdf5.jnilib"
else
        hadoop fs -put ${BIDMAT_ROOT}/lib/linux64 linux64
        export FILES="linux64/HDF5_Copyright.html,linux64/JCUDA4.2,linux64/JCUDA5.0,linux64/JCUDA_Copyright.txt,linux64/libbidmatmkl.so,linux64/libhdf4.settings,linux64/libhdf5.settings,linux64/libiomp5.so,linux64/libjhdf5.so,linux64/libjhdf.so"
fi

hadoop jar runJar.jar -libjars ${LIB_JARS} -files ${FILES} "BIDMatExample" input output

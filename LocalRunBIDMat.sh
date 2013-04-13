#!/bin/bash
export BIDMAT_ROOT="/Users/dcheng090/Software/BIDMat" #MODIFY THIS WITH BIDMAT LOCATION
export SCALA_ROOT="/Users/dcheng090/DmgFiles/scala-2.9.2/lib" #MODIFY THIS WITH SCALA LOCATION

# This is only needed/works on Linux

export JCUDA_VERSION="0.4.2"
export JCUDA_LIBDIR=${BIDMAT_ROOT}/lib
export LIBDIR=${BIDMAT_ROOT}/lib

export BIDMAT_LIBS="${BIDMAT_ROOT}/BIDMat.jar:${LIBDIR}/ptplot.jar:${LIBDIR}/ptplotapplication.jar:${LIBDIR}/jhdf5.jar"
export JCUDA_LIBS="${JCUDA_LIBDIR}/jcuda-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcublas-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcufft-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcurand-${JCUDA_VERSION}.jar:${JCUDA_LIBDIR}/jcusparse-${JCUDA_VERSION}.jar"
export MATIO_LIBS="lib/BIDMatWithHDFS.jar" #MODIFY THIS WITH BIDMatWithHDFS jar
export HADOOP_LIBS="/usr/local/Cellar/hadoop/1.0.4/libexec/hadoop-core-1.0.4.jar:/usr/local/Cellar/hadoop/1.0.4/libexec/lib/commons-logging-1.1.1.jar" #MODIFY THIS WITH HADOOP LIBS
export SCALA_LIBS="${SCALA_ROOT}/jline.jar:${SCALA_ROOT}/scala-compiler.jar:${SCALA_ROOT}/scala-library.jar:${SCALA_ROOT}/scalap.jar:${SCALA_ROOT}/scalacheck.jar:${SCALA_ROOT}/scala-dbc.jar:${SCALA_ROOT}/scala-partest.jar:${SCALA_ROOT}/scala-swing.jar"


export LD_LIBRARY_PATH="${BIDMAT_ROOT}/lib/linux64:${BIDMAT_ROOT}/lib/linux64/JCUDA4.2" #:/usr/local/cuda-4.2/lib64:${LD_LIBRARY_PATH}"

export DYLD_LIBRARY_PATH="${BIDMAT_ROOT}/lib/osx64:${BIDMAT_ROOT}/lib/osx64/JCUDA5.0:${LD_LIBRARY_PATH}"

export ALL_LIBS="${SCALA_LIBS}:${MATIO_LIBS}:${HADOOP_LIBS}:${BIDMAT_LIBS}:${JCUDA_LIBS}" #:${JAVA_HOME}/lib/tools.jar"

#export HADOOP_USER_CLASSPATH_FIRST="true"
export HADOOP_CLASSPATH="${ALL_LIBS}"
#export HADOOP_CLASSPATH=lib/scala-library.jar:lib/BIDMat.jar:lib/jline-2.9.2.jar
export LIB_JARS=`echo ${HADOOP_CLASSPATH} | sed s/:/,/g`

if [ `uname` = "Darwin" ]; then
	hadoop fs -put ${BIDMAT_ROOT}/lib/osx64/ osx64
	export FILES="osx64/HDF5_Copyright.html,osx64/JCUDA5.0,osx64/JCUDA_Copyright.txt,osx64/libbidmatmkl.jnilib,osx64/libhdf4.settings,osx64/libhdf5.settings,osx64/libiomp5.dylib,osx64/libjhdf.jnilib,osx64/libjhdf5.jnilib"
else
	hadoop fs -put ${BIDMAT_ROOT}/lib/linux64 linux64
	export FILES="linux64/libhdf4.settings,linux64/libhdf5.settings,linux64/libiomp5.so,linux64/libjhdf.so,linux64/libjhdf5.so"
fi

export HI=`ls -dm osx64/* | tr -d " "`
echo ${HI}
#echo $FILES

hadoop jar runJar.jar -libjars ${LIB_JARS} -files ${FILES} "BIDMatExample" input output

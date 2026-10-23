export SPARK_HOME="$HOME/opt/spark-3.5.3-bin-without-hadoop"
export PATH="$SPARK_HOME/bin:$PATH"
export HADOOP_CONF_DIR=/etc/hadoop
export YARN_CONF_DIR="$HADOOP_CONF_DIR"
export SPARK_DIST_CLASSPATH="$(hadoop classpath)"
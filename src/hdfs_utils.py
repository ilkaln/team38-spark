def get_hdfs_filesystem(spark):
    hadoop_conf = spark.sparkContext._jsc.hadoopConfiguration()
    jvm = spark.sparkContext._jvm

    return jvm.org.apache.hadoop.fs.FileSystem.get(hadoop_conf)


def list_hdfs_path(spark, path="/"):
    filesystem = get_hdfs_filesystem(spark)
    jvm = spark.sparkContext._jvm
    hdfs_path = jvm.org.apache.hadoop.fs.Path(path)

    if not filesystem.exists(hdfs_path):
        raise FileNotFoundError(f"HDFS path does not exist: {path}")

    return filesystem.listStatus(hdfs_path)

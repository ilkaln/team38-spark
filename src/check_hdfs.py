from spark_session import create_spark_session, stop_spark_session
from hdfs_utils import get_hdfs_filesystem, list_hdfs_path


def main():
    spark = create_spark_session("team38-check-hdfs")

    try:
        print(f"Spark version: {spark.version}")
        print(f"Spark master: {spark.sparkContext.master}")
        print(f"Application ID: {spark.sparkContext.applicationId}")

        filesystem = get_hdfs_filesystem(spark)
        print(f"Connected filesystem: {filesystem.getUri()}")

        print("Root directory contents:")
        for status in list_hdfs_path(spark, "/"):
            entry_type = "DIR " if status.isDirectory() else "FILE"
            print(f"  {entry_type} {status.getPath()}")

        print("HDFS connection check: SUCCESS")

    finally:
        stop_spark_session(spark)


if __name__ == "__main__":
    main()


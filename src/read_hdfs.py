import argparse

from spark_session import create_spark_session, stop_spark_session
from hdfs_utils import get_hdfs_filesystem


def main():
    parser = argparse.ArgumentParser(
        description="Read data from HDFS using Spark"
    )
    parser.add_argument("path", help="Path to the input data in HDFS")
    parser.add_argument(
        "--format",
        choices=["csv", "json", "parquet", "text"],
        required=True,
        help="Input data format",
    )
    args = parser.parse_args()

    spark = create_spark_session("team38-read-hdfs")

    try:
        print(f"Spark version: {spark.version}")
        print(f"Spark master: {spark.sparkContext.master}")
        print(f"Application ID: {spark.sparkContext.applicationId}")

        filesystem = get_hdfs_filesystem(spark)
        hdfs_path = spark.sparkContext._jvm.org.apache.hadoop.fs.Path(
            args.path
        )

        print(f"Connected filesystem: {filesystem.getUri()}")

        if not filesystem.exists(hdfs_path):
            raise FileNotFoundError(
                f"Input path does not exist in HDFS: {args.path}"
            )

        reader = spark.read.format(args.format)

        if args.format == "csv":
            reader = reader.option("header", "true").option(
                "inferSchema", "true"
            )

        dataframe = reader.load(args.path)

        print(f"Input path: {args.path}")
        print(f"Input format: {args.format}")

        print("Data schema:")
        dataframe.printSchema()

        print("First 20 rows:")
        dataframe.show(20, truncate=False)

        print("HDFS data read: SUCCESS")

    finally:
        stop_spark_session(spark)


if __name__ == "__main__":
    main()


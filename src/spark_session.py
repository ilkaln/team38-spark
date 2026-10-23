from pyspark.sql import SparkSession


def create_spark_session(app_name: str, enable_hive: bool = False) -> SparkSession:
    builder = SparkSession.builder.appName(app_name)

    if enable_hive:
        builder = builder.enableHiveSupport()

    return builder.getOrCreate()


def stop_spark_session(spark: SparkSession) -> None:
    spark.stop()


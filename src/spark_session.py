from pyspark.sql import SparkSession


def create_spark_session(app_name: str) -> SparkSession:
    """Create or retrieve a Spark session for this application."""
    return (
        SparkSession.builder
        .appName(app_name)
        .getOrCreate()
    )


def stop_spark_session(spark: SparkSession) -> None:
    """Stop the Spark session and release its resources."""
    spark.stop()


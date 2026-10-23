from pyspark.sql import DataFrame, SparkSession
from pyspark.sql import functions as F


def load_and_transform_penguins(
    spark: SparkSession,
    hdfs_path: str,
) -> DataFrame:

    dataframe = (
        spark.read
        .option("header", "true")
        .option("inferSchema", "false")
        .csv(hdfs_path)
    )

    dataframe = (
        dataframe
        .withColumn("bill_length_mm", F.col("bill_length_mm").cast("double"))
        .withColumn("bill_depth_mm", F.col("bill_depth_mm").cast("double"))
        .withColumn("flipper_length_mm", F.col("flipper_length_mm").cast("integer"))
        .withColumn("body_mass_g", F.col("body_mass_g").cast("integer"))
        .withColumn("year", F.col("year").cast("integer"))
    )

    dataframe = dataframe.filter(
        F.col("species").isNotNull()
        & F.col("island").isNotNull()
        & F.col("body_mass_g").isNotNull()
        & F.col("flipper_length_mm").isNotNull()
    )

    return dataframe

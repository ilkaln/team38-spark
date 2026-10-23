import argparse

from spark_session import create_spark_session, stop_spark_session


DEFAULT_DATA_PATH = (
    "hdfs://team-38-nn:9000/user/team/spark-course/"
    "output/penguins_partitioned"
)

TABLE_NAME = "penguins_filtered"


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Save transformed penguins data as a Spark SQL table."
    )
    parser.add_argument(
        "data_path",
        nargs="?",
        default=DEFAULT_DATA_PATH,
        help="Path to the partitioned Parquet data in HDFS.",
    )
    args = parser.parse_args()

    spark = create_spark_session("team38-save-penguins-table")

    try:
        dataframe = spark.read.parquet(args.data_path)

        table_path = (
            "hdfs://team-38-nn:9000/user/team/spark-course/"
            "tables/penguins_filtered"
        )

        (
            dataframe.write
            .mode("overwrite")
            .format("parquet")
            .option("path", table_path)
            .saveAsTable(TABLE_NAME)
        )

        print(f"Table created: {TABLE_NAME}")
        print("Table schema:")
        spark.table(TABLE_NAME).printSchema()

        print("Rows grouped by species:")
        spark.sql(
            f"""
            SELECT species, COUNT(*) AS penguin_count
            FROM {TABLE_NAME}
            GROUP BY species
            ORDER BY species
            """
        ).show(truncate=False)

    finally:
        stop_spark_session(spark)

if __name__ == "__main__":
    main()


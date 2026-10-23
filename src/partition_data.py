import argparse
from pathlib import Path

from spark_session import create_spark_session, stop_spark_session
from penguins_data import load_and_transform_penguins


PROJECT_DIR = Path(__file__).resolve().parent.parent
SQL_PATH = PROJECT_DIR / "sql" / "filter_and_sort.sql"

DEFAULT_INPUT_PATH = (
    "hdfs://team-38-nn:9000/user/team/spark-course/input/penguins.csv"
)
DEFAULT_OUTPUT_PATH = (
    "hdfs://team-38-nn:9000/user/team/spark-course/"
    "output/penguins_partitioned"
)


def main():
    parser = argparse.ArgumentParser(
        description="Save transformed penguins data with partitioning"
    )
    parser.add_argument("input_path", nargs="?", default=DEFAULT_INPUT_PATH)
    parser.add_argument("output_path", nargs="?", default=DEFAULT_OUTPUT_PATH)
    args = parser.parse_args()

    spark = create_spark_session("team38-partition-penguins")

    try:
        dataframe = load_and_transform_penguins(spark, args.input_path)
        dataframe.createOrReplaceTempView("penguins")

        query = SQL_PATH.read_text(encoding="utf-8")
        result = spark.sql(query)

        (
            result.write
            .mode("overwrite")
            .partitionBy("species")
            .parquet(args.output_path)
        )

        print(f"Partitioned data saved to: {args.output_path}")
    finally:
        stop_spark_session(spark)


if __name__ == "__main__":
    main()

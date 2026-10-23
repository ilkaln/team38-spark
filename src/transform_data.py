import argparse
from pathlib import Path

from spark_session import create_spark_session, stop_spark_session
from penguins_data import load_and_transform_penguins


PROJECT_DIR = Path(__file__).resolve().parent.parent
SQL_DIR = PROJECT_DIR / "sql"


def execute_sql_file(spark, filename):
    sql_path = SQL_DIR / filename
    query = sql_path.read_text(encoding="utf-8")

    print(f"\nSQL file: {sql_path.name}")
    result = spark.sql(query)
    result.show(50, truncate=False)

    return result


def main():
    parser = argparse.ArgumentParser(
        description="Transform Palmer Penguins data using Spark SQL"
    )
    parser.add_argument(
        "path",
        nargs="?",
        default="hdfs://team-38-nn:9000/user/team/spark-course/input/penguins.csv",
        help="Path to the input CSV file in HDFS",
    )
    args = parser.parse_args()

    spark = create_spark_session("team38-transform-penguins")

    try:
        print(f"Spark version: {spark.version}")
        print(f"Spark master: {spark.sparkContext.master}")
        print(f"Application ID: {spark.sparkContext.applicationId}")

        dataframe = load_and_transform_penguins(spark, args.path)
        dataframe.createOrReplaceTempView("penguins")

        execute_sql_file(spark, "filter_and_sort.sql")
        execute_sql_file(spark, "species_statistics.sql")

        print("\nData transformations: SUCCESS")
    finally:
        stop_spark_session(spark)


if __name__ == "__main__":
    main()

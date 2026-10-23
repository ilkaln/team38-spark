from spark_session import create_spark_session, stop_spark_session


def main():
    spark = create_spark_session("team38-spark-homework")

    try:
        print(f"Spark version: {spark.version}")
        print(f"Spark master: {spark.sparkContext.master}")
        print(f"Application ID: {spark.sparkContext.applicationId}")
    finally:
        stop_spark_session(spark)


if __name__ == "__main__":
    main()

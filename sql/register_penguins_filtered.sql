
CREATE EXTERNAL TABLE IF NOT EXISTS penguins_filtered (
    island STRING,
    sex STRING,
    flipper_length_mm INT,
    body_mass_g INT,
    body_mass_kg DECIMAL(15, 3),
    species STRING
)
STORED AS PARQUET
LOCATION 'hdfs://team-38-nn:9000/user/team/spark-course/tables/penguins_filtered';

SET hive.execution.engine=mr;

ADD JAR /home/team/opt/apache-hive-4.1.0-bin/lib/commons-collections-3.2.2.jar;

SELECT species, COUNT(*) AS penguin_count
FROM penguins_filtered
GROUP BY species
ORDER BY species;

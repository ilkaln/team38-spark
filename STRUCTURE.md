## Содержание файлов работы

### Скрипты (`scripts/`)

| Файл | Назначение |
|---|---|
| `setup_spark.sh` | Установка Spark |
| `check_yarn.sh` | Проверка YARN |
| `spark_env.sh` | Настройка окружения Spark |
| `run_session.sh` | Запуск Spark-сессии |
| `hdfs_connection.sh` | Проверка HDFS |
| `read_hdfs.sh` | Чтение данных из HDFS |
| `transform_data.sh` | Запуск трансформаций |
| `partition_data.sh` | Запись с партиционированием |
| `save_table.sh` | Сохранение таблицы |
| `setup_hive.sh` | Установка Hive |
| `register_hive_table.sh` | Регистрация таблицы в Hive и проверка запроса |
| `prepare_dataset.sh` | Подготовка исходных данных |

### Исходный код (`src/`)

| Файл | Назначение |
|---|---|
| `spark_session.py` | Создание SparkSession |
| `start_spark_session.py` | Запуск сессии Spark |
| `check_hdfs.py` | Проверка подключения к HDFS |
| `read_hdfs.py` | Чтение данных из HDFS |
| `transform_data.py` | Трансформация данных |
| `partition_data.py` | Партиционирование данных |
| `save_table.py` | Сохранение данных в таблицу |
| `hdfs_utils.py` | Вспомогательные операции HDFS |
| `penguins_data.py` | Загрузка и подготовка датасета|

### SQL-запросы (`sql/`)

| Файл | Назначение |
|---|---|
| `filter_and_sort.sql` | Фильтрация и сортировка |
| `species_statistics.sql` | Статистика по видам |
| `register_penguins_filtered.sql` | Регистрация таблицы и проверка Hive |

---
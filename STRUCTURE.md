

## Содержание файлов работы

### Скрипты (`scripts/`)

| Файл | Назначение |
|---|---|
| `setup_spark.sh` | Установка Spark |
| `setup_hive.sh` | Установка Hive |
| `spark_env.sh` | Настройка окружения Spark |
| `check_yarn.sh` | Проверка YARN |
| `hdfs_connection.sh` | Проверка HDFS |
| `run_session.sh` | Запуск Spark-приложений |
| `prepare_dataset.sh` | Подготовка исходных данных |
| `read_hdfs.sh` | Чтение данных из HDFS |
| `transform_data.sh` | Запуск трансформаций |
| `partition_data.sh` | Запись с партиционированием |
| `save_table.sh` | Сохранение таблицы |
| `register_hive_table.sh` | Регистрация таблицы в Hive и проверка запроса |

### Исходный код (`src/`)

| Файл | Назначение |
|---|---|
| `spark_session.py` | Создание SparkSession |
| `start_spark_session.py` | Запуск сессии Spark |
| `check_hdfs.py` | Проверка подключения к HDFS |
| `hdfs_utils.py` | Вспомогательные операции HDFS |
| `penguins_data.py` | Загрузка и подготовка данных |
| `read_hdfs.py` | Чтение данных из HDFS |
| `transform_data.py` | Трансформация данных |
| `partition_data.py` | Партиционирование данных |
| `save_table.py` | Сохранение данных в таблицу |

### SQL-запросы (`sql/`)

| Файл | Назначение |
|---|---|
| `filter_and_sort.sql` | Фильтрация и сортировка |
| `species_statistics.sql` | Статистика по видам |
| `register_penguins_filtered.sql` | Регистрация таблицы и проверка Hive |

---
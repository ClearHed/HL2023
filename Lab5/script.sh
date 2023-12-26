docker exec -i -t bccf55c69242 /bin/bash
cd /test-files

///Scala:
import org.apache.spark.sql.{SparkSession, functions}
val df = spark.read.option("header", "true").csv("/test-files/rides.csv")

1)
- топ 100 водіїв за рейтингом
df.groupBy("driver_id").agg(functions.avg("driver_rate").alias("average_rate")).orderBy(functions.col("average_rate").desc).limit(100).show()

2)
- кого з водіїв ми маємо зняти з нашої системи ( рейтинг менше 3,5)
df.groupBy("driver_id").agg(functions.avg("driver_rate").alias("average_rate")).filter("average_rate < 3.5").orderBy(functions.col("average_rate").desc).show()

3)
- в який проміжок часу здійснюється найбільше поїздок
val dfWithTimestamp = df.withColumn("start_time", functions.to_timestamp(df("start_time")))
dfWithTimestamp.withColumn("hour", functions.hour(dfWithTimestamp("start_time"))).groupBy("hour").count().orderBy(functions.col("count").desc).select("hour").show()

4)
- топ 50 клієнтів за рейтингом
df.groupBy("client_id").agg(functions.avg("client_rate").alias("average_rate")).orderBy(functions.col("average_rate").desc).limit(50).show()

5)
- топ 100 водів, що заробили найбільше
df.groupBy("driver_id").agg(functions.sum("cost").alias("total_cost"), functions.sum("cost").alias("total_cost_sum")).orderBy(functions.col("total_cost").desc).select("driver_id", "total_cost_sum").limit(100).show()

6)
- топ 50 - водіїв, які переважно їздять вночі
val dfWithTimestamp = df.withColumn("start_time", functions.col("start_time").cast("timestamp"))
dfWithTimestamp.filter(functions.hour(dfWithTimestamp("start_time")) > 22 || functions.hour(dfWithTimestamp("start_time")) < 7).select("driver_id").limit(50).show()

7)
- за що (яка категорія) найчастіше водіїв хвалять
df.groupBy("category_driver_feedback").agg(functions.count("*").alias("count")).orderBy(functions.col("count").desc).show()

8)
- на що (найчастіше) скаржаться клієнти (категорія)
val selectedCategories = Seq("awful service", "bad car", "unpleasant companion", "dirty", "non-expert navigation", "not recommend")
df.groupBy("category_client_feedback").count().orderBy($"count".desc).filter($"category_client_feedback".isin(selectedCategories: _*)).show()

9)
- Топ 10 найдовших текстових коментарів
df.select("text_client_feedback").orderBy(functions.length($"text_client_feedback").desc).limit(10).show()


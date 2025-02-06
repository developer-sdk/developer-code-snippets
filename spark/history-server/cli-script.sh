# 실행 
/opt/java/openjdk/bin/java -cp \
/opt/spark/conf/:/opt/spark/jars/*:/etc/hadoop/conf/:/opt/hadoop/share/hadoop/common/lib/*:/opt/hadoop/share/hadoop/common/*:/opt/hadoop/share/hadoop/hdfs/:/opt/hadoop/share/hadoop/hdfs/lib/*:/opt/hadoop/share/hadoop/hdfs/*:/opt/hadoop/share/hadoop/yarn/:/opt/hadoop/share/hadoop/yarn/lib/*:/opt/hadoop/share/hadoop/yarn/*:/opt/hadoop/share/hadoop/mapreduce/lib/*:/opt/hadoop/share/hadoop/mapreduce/*:mysql-connector-java.jar/etc/tez/conf:/opt/tez/*:/opt/tez/lib/*:/opt/hadoop/share/hadoop/tools/lib/* \
-Dspark.root.logger=console \
-Dspark.log.dir=/var/log/spark \
-Dspark.log.file=spark-ubuntu-historyserver.log -Xmx1g \
org.apache.spark.deploy.history.HistoryServer

# 로그 디렉토리, UI 포트 적용 
/opt/java/openjdk/bin/java -cp \
/opt/spark/conf/:/opt/spark/jars/*:/etc/hadoop/conf/:/opt/hadoop/share/hadoop/common/lib/*:/opt/hadoop/share/hadoop/common/*:/opt/hadoop/share/hadoop/hdfs/:/opt/hadoop/share/hadoop/hdfs/lib/*:/opt/hadoop/share/hadoop/hdfs/*:/opt/hadoop/share/hadoop/yarn/:/opt/hadoop/share/hadoop/yarn/lib/*:/opt/hadoop/share/hadoop/yarn/*:/opt/hadoop/share/hadoop/mapreduce/lib/*:/opt/hadoop/share/hadoop/mapreduce/*:mysql-connector-java.jar/etc/tez/conf:/opt/tez/*:/opt/tez/lib/*:/opt/hadoop/share/hadoop/tools/lib/* \
-Dspark.history.fs.logDirectory=s3://bucket-name/spark-apps \
-Dspark.history.ui.port=28082 \
-Dspark.root.logger=console \
-Dspark.log.dir=/var/log/spark \
-Dspark.log.file=spark-ubuntu-historyserver.log -Xmx1g \
org.apache.spark.deploy.history.HistoryServer

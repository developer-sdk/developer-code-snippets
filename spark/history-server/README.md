## **Apache Spark History Server 개요**

### **1. Spark History Server란?**
Spark History Server는 Spark 애플리케이션 실행 기록을 저장하고, 웹 UI를 통해 과거 실행된 작업을 분석할 수 있도록 지원하는 모니터링 도구입니다.  
Spark의 기본 웹 UI는 애플리케이션이 실행되는 동안에만 제공되지만, History Server를 사용하면 애플리케이션이 종료된 후에도 실행 기록을 확인할 수 있습니다.

---

### **2. Spark History Server의 주요 기능**
1. **완료된 애플리케이션의 실행 로그 조회**  
   - 작업(Job), 스테이지(Stage), 태스크(Task) 단위로 세부 실행 정보 제공  
   - Executor, Driver의 리소스 사용량 확인 가능  

2. **성능 튜닝 및 문제 분석**  
   - 실행된 애플리케이션의 병목 현상 분석  
   - 실패한 작업의 원인 파악  

3. **여러 애플리케이션의 실행 기록 관리**  
   - 단일 인터페이스에서 다수의 Spark 애플리케이션을 모니터링 가능  

---

### **3. Spark History Server 작동 원리**
1. Spark 애플리케이션이 실행되면 `spark event log`를 HDFS, S3 또는 로컬 디렉토리에 저장
   1. 사용자 설정에 따라 HDFS, S3를 설정할 수 있음 
2. History Server는 해당 `spark event log`를 읽어 Spark UI에서 조회 가능하도록 변환  
3. 사용자는 웹 브라우저를 통해 완료된 애플리케이션의 실행 기록을 확인  

---

### **4. Spark History Server 설정 방법**
#### **(1) Spark 이벤트 로그 활성화**
`$SPARK_HOME/conf/spark-defaults.conf` 파일에서 아래 설정 추가:
```properties
# 이벤트 로그 저장 여부 확인 
spark.eventLog.enabled             true
spark.eventLog.dir                 hdfs://namenode:8020/spark-history
# 히스토리 서버가 실행 될 때 파일을 읽는 위치 설정 
spark.history.fs.logDirectory      hdfs://namenode:8020/spark-history
spark.history.retainedApplications 50
```

- `spark.eventLog.enabled` → 이벤트 로그 활성화
- `spark.eventLog.dir` → 실행 로그 저장 경로 설정 (HDFS 또는 로컬 경로)
- `spark.history.fs.logDirectory` → History Server에서 참조할 로그 디렉토리
- `spark.history.retainedApplications` → 보관할 애플리케이션 실행 기록 개수 설정

#### **(2) Spark History Server 실행**
아래 명령어를 실행하여 Spark History Server를 시작합니다:
```sh
$SPARK_HOME/sbin/start-history-server.sh
```

#### **(3) 웹 UI 접속**
기본적으로 `http://<HISTORY_SERVER_HOST>:18080`에서 Spark History Server 웹 UI에 접속할 수 있습니다.

---

### **5. Spark History Server 활용 사례**
- **애플리케이션 성능 최적화**: 실행 시간, 셔플(Shuffle) 연산 비용, 스테이지 간 병목 분석  
- **에러 및 장애 분석**: 실패한 작업(Task) 또는 노드에서 발생한 문제 식별  
- **리소스 사용 모니터링**: Executor별 CPU 및 메모리 사용량 분석  

---

### **6. Spark History Server 최적화 및 유지보수**
1. **로그 보관 주기 관리**  
   - 불필요한 로그를 정기적으로 삭제하여 저장 공간 절약  
   - 예: `spark.history.retainedApplications` 값을 적절히 조정  

2. **로그 저장소 성능 최적화**  
   - 많은 애플리케이션이 기록될 경우 HDFS/S3와 같은 분산 저장소 사용 권장  

3. **History Server 성능 개선**  
   - `spark.history.fs.cleaner.enabled` 옵션을 활성화하여 오래된 로그 정리  
   - 서버 메모리 및 CPU 모니터링하여 리소스 적절히 할당  

---

### **7. Spark History Server와 대체 모니터링 도구 비교**
| 모니터링 도구 | 실행 중인 애플리케이션 | 완료된 애플리케이션 | 주요 기능 |
|--------------|------------------|------------------|----------|
| Spark UI | ✅ | ❌ | 실행 중인 Spark 애플리케이션 모니터링 |
| Spark History Server | ❌ | ✅ | 완료된 애플리케이션 로그 분석 |
| Ganglia | ✅ | ✅ | 클러스터 리소스 모니터링 |
| Prometheus + Grafana | ✅ | ✅ | 메트릭 수집 및 시각화 |

---

### **8. 결론**
Spark History Server는 Spark 애플리케이션의 실행 기록을 저장하고 시각화하여 성능 분석과 문제 해결에 도움을 주는 필수적인 도구입니다.  
대규모 클러스터 환경에서는 HDFS 또는 S3와 연동하여 로그를 효율적으로 관리하는 것이 중요합니다.
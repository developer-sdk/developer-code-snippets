### **Transactional Outbox Pattern 정리**  

#### **1. 개요**  
Transactional Outbox Pattern은 마이크로서비스 아키텍처에서 데이터베이스 트랜잭션과 이벤트 발행의 일관성을 보장하기 위한 패턴이다.  

마이크로서비스에서는 데이터베이스 업데이트와 동시에 메시지 브로커(Kafka, RabbitMQ 등)에 이벤트를 발행해야 하는 경우가 많다. 하지만 이를 직접 처리하면 **이중 기록 문제(Dual Write Problem)** 가 발생할 수 있다.  
Transactional Outbox Pattern은 이를 해결하기 위해 **Outbox 테이블**을 사용하여 데이터 일관성을 유지하는 전략이다.  

---

#### **2. 문제점 (이중 기록 문제, Dual Write Problem)**  
트랜잭션과 메시지 발행이 따로 수행되면 다음과 같은 문제가 발생할 수 있다.  

1. **데이터베이스는 업데이트되었으나 메시지 발행이 실패**  
2. **메시지는 발행되었으나 데이터베이스 업데이트가 롤백됨**  

이러한 상황은 데이터 불일치 문제를 초래하고, 시스템의 신뢰성을 낮춘다.  

---

#### **3. 해결 방법 (Transactional Outbox Pattern)**
Transactional Outbox Pattern은 **Outbox 테이블**을 사용하여 다음 단계를 따른다.  

1. **데이터와 함께 Outbox 테이블에 이벤트 저장 (트랜잭션 내 처리)**  
   - 비즈니스 로직 수행 시 데이터 변경과 함께 메시지를 Outbox 테이블에 삽입  
   - 데이터와 메시지가 동일한 트랜잭션으로 커밋되므로 일관성 보장  

2. **별도의 프로세스(폴링 또는 CDC)에서 Outbox 테이블을 읽고 메시지 브로커로 전송**  
   - Outbox 테이블을 주기적으로 스캔하여 새로운 이벤트가 있으면 메시지를 브로커(Kafka, RabbitMQ 등)로 발행  
   - 성공적으로 발행된 이벤트는 Outbox 테이블에서 삭제  

이렇게 하면 데이터베이스와 메시지의 일관성이 보장되며, 메시지 브로커 장애 발생 시에도 재시도를 통해 안정적인 메시지 전송이 가능하다.  

---

#### **4. Outbox 패턴 구현 방식**  
Outbox 패턴을 구현하는 방법은 크게 **Polling 방식**과 **CDC 방식** 두 가지가 있다.  

1. **Polling 방식**  
   - 주기적으로 Outbox 테이블을 조회하여 새 이벤트가 있으면 메시지 브로커에 발행  
   - 발행이 완료되면 해당 이벤트를 삭제 또는 상태 업데이트  
   - 구현이 간단하지만 지연(latency)이 발생할 수 있음  

2. **Change Data Capture(CDC) 방식**  
   - 데이터베이스의 변경 로그(Change Log)를 읽어 Outbox 테이블의 변경 사항을 감지  
   - Kafka Connect, Debezium 같은 CDC 도구를 활용하여 변경 데이터를 메시지 브로커로 전송  
   - 더 빠르고 실시간성이 뛰어나지만 CDC 인프라가 필요함  

---

#### **5. 장점과 단점**  

✅ **장점**  
- 데이터베이스와 메시지의 일관성을 보장  
- 메시지 발행 실패 시에도 재시도 가능  
- 메시지 브로커 장애 시에도 Outbox 테이블을 통해 데이터 보존 가능  

⚠️ **단점**  
- Outbox 테이블을 관리하기 위한 추가적인 로직 필요  
- Polling 방식은 일정한 지연 시간이 발생 가능  
- CDC 방식은 추가적인 인프라 요구됨  

---

#### **6. 결론**  
Transactional Outbox Pattern은 마이크로서비스에서 **데이터 일관성을 유지하면서 이벤트를 안전하게 발행하는 방법**으로 널리 사용된다.  
특히, Kafka + Debezium과 같은 CDC 기반 솔루션을 활용하면 성능과 실시간성이 보장될 수 있다.  

이 패턴을 사용하면 마이크로서비스 간의 메시징을 안정적으로 처리할 수 있으며, 장애 발생 시에도 데이터 정합성을 유지할 수 있다.


+ [Transactional Outbox 패턴으로 메시지 발행 보장하기](https://ridicorp.com/story/transactional-outbox-pattern-ridi/)
+ [분산 시스템에서 메시지 안전하게 다루기](https://blog.gangnamunni.com/post/transactional-outbox/)
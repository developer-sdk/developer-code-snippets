probe 를 이용해서 상태를 점검할 수 없다.

Kubernetes(K8s)에서 **Liveness Probe**와 **Readiness Probe**는 컨테이너의 상태를 체크하여 애플리케이션의 신뢰성을 높이는 데 사용된다. 각각의 역할과 설정 방법을 알아보자.

---

## 🔹 Liveness Probe (생존 여부 체크)
**용도**:  
- 애플리케이션이 **정상적으로 실행 중인지** 확인하는 역할.
- 만약 Liveness Probe가 실패하면 K8s는 해당 컨테이너를 강제로 재시작함.

**사용 예시**:
- 애플리케이션이 **데드락** 상태에 빠져 더 이상 정상적으로 동작하지 않을 때.
- 프로세스가 실행 중이지만 응답을 하지 않는 경우.

**설정 방법**:
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 3  # 컨테이너 시작 후 최초 체크 대기 시간
  periodSeconds: 5        # 이후 주기적으로 체크하는 간격
  failureThreshold: 3     # 연속으로 실패할 경우 컨테이너를 재시작
```

> 위 설정은 `/healthz` 엔드포인트에 HTTP 요청을 보내서 정상 응답이 오지 않으면 컨테이너를 재시작한다.

---

## 🔹 Readiness Probe (준비 상태 체크)
**용도**:  
- 애플리케이션이 **트래픽을 받을 준비가 되었는지** 확인하는 역할.
- Readiness Probe가 실패하면 해당 **Pod는 서비스에서 제외됨** (즉, 트래픽을 받지 않음).

**사용 예시**:
- 데이터베이스 연결이 완료되지 않은 상태에서 트래픽을 받지 않도록 하기 위해.
- 애플리케이션의 필수 초기화 작업이 끝나지 않은 경우.

**설정 방법**:
```yaml
readinessProbe:
  tcpSocket:
    port: 5432  # 특정 포트에서 연결 가능 여부 확인
  initialDelaySeconds: 5
  periodSeconds: 10
  failureThreshold: 3
```
> 위 설정은 **TCP 연결 가능 여부**를 체크하여 트래픽을 받을 준비가 되면 서비스에 포함한다.

---

## 🔹 Liveness vs Readiness 차이점

| Feature          | Liveness Probe | Readiness Probe |
|-----------------|---------------|----------------|
| 목적            | 컨테이너의 생존 여부 확인 | 서비스 요청을 받을 준비가 되었는지 확인 |
| 실패 시 동작     | 컨테이너 재시작 | 서비스에서 Pod 제외 (트래픽 차단) |
| 예제 상황       | 애플리케이션이 응답하지 않음 | DB 연결이 아직 안 된 상태 |
| 재시작 여부     | ✅ 예 | ❌ 아니오 |

---

## 🔹 Startup Probe (추가 기능)
**용도**:  
- Liveness Probe보다 **긴 시간이 걸리는 초기화 과정**을 지원하기 위해 사용됨.
- 애플리케이션이 시작되기 전까지는 Liveness Probe를 실행하지 않도록 함.

**설정 예시**:
```yaml
startupProbe:
  httpGet:
    path: /healthz
    port: 8080
  failureThreshold: 30  # 최대 30번 실패할 수 있음
  periodSeconds: 5
```
> 위 설정은 **최대 30번(= 5초 간격 × 30회 = 150초)까지 대기 후**, 그 이후에도 응답이 없으면 컨테이너를 재시작한다.

---

## ✅ 요약
- **Liveness Probe** → 애플리케이션이 **정상적으로 실행 중인지 확인**, 실패하면 **재시작**.
- **Readiness Probe** → 애플리케이션이 **트래픽을 받을 준비가 되었는지 확인**, 실패하면 **서비스에서 제외**.
- **Startup Probe** → Liveness Probe보다 **긴 초기화 과정**이 필요한 경우 사용.

---

이제 Kubernetes에서 Liveness, Readiness Probe를 설정하여 더욱 안정적인 서비스를 운영할 수 있다! 🚀

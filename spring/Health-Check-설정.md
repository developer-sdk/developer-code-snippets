Java Spring에서 다른 HTTP 서버에 Health Check를 수행하고 응답이 정상일 때 성공을 반환하는 방법은 여러 가지가 있지만, 가장 일반적인 방법은 `RestTemplate` 또는 `WebClient`를 사용하는 것입니다.  

---

## 1. `RestTemplate`을 이용한 Health Check
Spring Boot 2.x까지는 `RestTemplate`이 일반적으로 사용되었습니다.  

### 예제 코드:
```java
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class HealthCheckService {

    private final RestTemplate restTemplate = new RestTemplate();
    private static final String TARGET_URL = "https://example.com/health";

    public boolean checkHealth() {
        try {
            ResponseEntity<String> response = restTemplate.getForEntity(TARGET_URL, String.class);
            return response.getStatusCode().is2xxSuccessful();
        } catch (Exception e) {
            return false;
        }
    }
}
```

위 코드는 `https://example.com/health`에 HTTP 요청을 보내고, 응답 코드가 `200 OK` 등의 정상 코드(2xx)인 경우 `true`를 반환합니다.  

---

## 2. `WebClient`를 이용한 Health Check (Spring WebFlux)
Spring Boot 2.x 이상에서는 `WebClient`가 권장됩니다.  

### 예제 코드:
```java
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class HealthCheckService {

    private final WebClient webClient;

    public HealthCheckService(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl("https://example.com").build();
    }

    public Mono<Boolean> checkHealth() {
        return webClient.get()
                .uri("/health")
                .retrieve()
                .toBodilessEntity()
                .map(response -> response.getStatusCode().is2xxSuccessful())
                .onErrorReturn(false);
    }
}
```

이 방식은 **비동기 처리**가 필요할 때 유용합니다. `Mono<Boolean>`을 반환하므로, 이를 구독하여 결과를 받을 수 있습니다.

---

## 3. `@Scheduled`을 활용한 정기적인 Health Check
정기적으로 서버의 Health Check를 수행하고 싶다면, `@Scheduled`을 사용할 수 있습니다.  

### 예제 코드:
```java
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class HealthCheckScheduler {

    private final HealthCheckService healthCheckService;

    public HealthCheckScheduler(HealthCheckService healthCheckService) {
        this.healthCheckService = healthCheckService;
    }

    @Scheduled(fixedRate = 60000) // 1분마다 실행
    public void performHealthCheck() {
        boolean isHealthy = healthCheckService.checkHealth();
        System.out.println("Health Check Result: " + (isHealthy ? "Healthy" : "Unhealthy"));
    }
}
```

---

## 4. Spring Boot Actuator를 활용한 Health Check 노출
Spring Boot에서 Actuator를 활성화하면 자체적인 Health Check 엔드포인트를 제공할 수 있습니다.

### 설정 방법 (`application.yml`)
```yaml
management:
  endpoints:
    web:
      exposure:
        include: health
```

이제 `http://localhost:8080/actuator/health` 로 접근하면 해당 애플리케이션의 상태를 확인할 수 있습니다.

---

이 방법들 중에서 원하는 방식으로 구현하면 다른 HTTP 서버에 대한 Health Check를 효과적으로 수행할 수 있습니다! 🚀

# 참고 
+ [Spring health check 설정 및 커스터마이징](https://medium.com/sjk5766/spring-health-check-%EC%84%A4%EC%A0%95-%EB%B0%8F-%EC%BB%A4%EC%8A%A4%ED%84%B0%EB%A7%88%EC%9D%B4%EC%A7%95-a123261d79bc)
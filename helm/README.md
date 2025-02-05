Helm은 Kubernetes 애플리케이션을 관리하는 패키지 매니저 입니다.
Helm을 사용하면 복잡한 Kubernetes 애플리케이션을 쉽게 배포하고, 설정을 관리할 수 있습니다. 

## **Helm 기본 개념**
- **Chart**: Kubernetes 리소스를 정의한 템플릿 모음 (애플리케이션 패키지)
- **Release**: 특정 버전의 Chart를 클러스터에 배포한 인스턴스
- **Repository**: Chart를 저장하고 공유하는 공간

---

## **Helm 주요 명령어**
### 1. **설치 및 초기화**
```sh
helm version  # Helm 버전 확인
helm repo add <repo-name> <repo-url>  # Helm Chart 저장소 추가
helm repo update  # 저장소 정보 업데이트
```

### 2. **Chart 검색 및 조회**
```sh
helm search hub <chart-name>  # Helm Hub에서 Chart 검색
helm search repo <chart-name>  # 추가한 저장소에서 Chart 검색
```

### 3. **애플리케이션 배포**
```sh
helm install <release-name> <chart-name>  # Chart를 기반으로 애플리케이션 배포
helm install <release-name> <repo/chart-name> --values values.yaml  # 커스텀 설정으로 배포
```

### 4. **배포 상태 확인**
```sh
helm list  # 배포된 Release 목록 확인
helm status <release-name>  # 특정 Release 상태 확인
helm history <release-name>  # 배포 이력 조회
```

### 5. **업데이트 및 롤백**
```sh
helm upgrade <release-name> <chart-name>  # 기존 배포 업데이트
helm rollback <release-name> <revision-number>  # 특정 버전으로 롤백
```

### 6. **제거**
```sh
helm uninstall <release-name>  # 배포된 애플리케이션 삭제
```

### 7. **템플릿 확인 및 디버깅**
```sh
helm template <chart-name>  # Chart의 Kubernetes 매니페스트 미리보기
helm lint <chart-name>  # Chart 문법 오류 검사
```

Helm을 사용하면 Kubernetes 애플리케이션 배포가 훨씬 편리해져. 필요한 기능 있으면 더 알려줄게! 😊
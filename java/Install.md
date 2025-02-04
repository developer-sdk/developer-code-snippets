# 자바 설치 

## Ubuntu 에 자바 설치 
- 원하는 자바 파일을 다운로드 
  - OpenJDK 홈페이지 접근 
    - https://wiki.openjdk.org/display/JDKUpdates/JDK+21u
  - Download 위치로 이동
    - https://adoptium.net/temurin/releases/?version=21
  - 원하는 버전의 JDK 다운로드 
    - Java 21 버전
      - OpenJDK21U-jdk_x64_linux_hotspot_21.0.2_13.tar.gz
  - Ubuntu 에 다운로드 하여 압축을 풀고, JAVA_HOME 설정 
    - export JAVA_HOME=/home/ubuntu/jdk-21.0.2+13

```bash
wget https://eclipse.c3sl.ufpr.br/temurin-compliance/temurin/21/jdk-21.0.2+13/OpenJDK21U-jdk_x64_linux_hotspot_21.0.2_13.tar.gz
tar zxf OpenJDK21U-jdk_x64_linux_hotspot_21.0.2_13.tar.gz
export JAVA_HOME=/home/ubuntu/jdk-21.0.2+13
```
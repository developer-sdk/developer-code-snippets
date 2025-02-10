# K8s 

# 개발 스크립트 
+ [인증서를 TLS 시크릿으로 변경](Tls-Secret-Generage.sh)
  + K8s는 인증서에 암호가 설정되어 있으면 동작하지 않기 때문에 인증서의 암호를 제거 해야 합니다. 
  + 암호 제거후 TLS 인증서를 Secret 으로 변경하여 사용할 수 있습니다. 

# 운영 스크립트 
+ [인그레스에 등록된 인증서의 만료일자 확인](Ingress-Certificate-Check.sh)
# 인증서의 암호 제거 
openssl rsa -in key.pem -out no_pass_key.pem

# 인증서를 secret 으로 변경 
kubectl create secret tls \
tls-secret \
--key no_pass_key.pem \
--cert cert.pem \
--dry-run=client \
-o yaml
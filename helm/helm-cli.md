
# dry-run
dry-run 을 이용하여 최종적으로 생성될 Yaml 파일을 확인할 수 있습니다. 

```bash
helm install \
<release-name> . \
--dry-run --debug \
--namespace <your-name-space> \
--values <custom-values>
```
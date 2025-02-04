# 크론탭

```bash
# 매일 1시 0분에 로그 정리 
0 1 * * * /home/ubuntu/crontab/clean_up_log.sh >> /home/ubuntu/crontab/logs/`date -u +\%Y\%m\%d.\%H\%M.log` 2>&1
```
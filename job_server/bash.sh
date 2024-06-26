curl -X POST http://localhost:4000/api/job \
     -H "Content-Type: application/json" \
     -H "Accept: text/plain" \
     --data-binary @job.json

curl -X POST http://localhost:4000/api/job \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -s --data-binary @bad_job.json

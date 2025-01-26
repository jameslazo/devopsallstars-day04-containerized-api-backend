.PHONY: run_api stop_api

run_api:
  docker build -t sports-api . && docker run --rm --name sports api -p 8080:8080 -d sports api

stop_api:
  docker stop sports-api

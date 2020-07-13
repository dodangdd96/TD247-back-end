up:
	docker-compose up -d
stop:
	docker-compose stop
	docker rm -f $(docker ps -a | grep demo_phoenix_api_app | awk '{print $1}') || echo "\n\n >bash stoped before\n\n"
app:
	docker rm -f demo_phoenix_api_app; docker-compose -f docker-compose.yml ${OTHER} run --name demo_phoenix_api_app --use-aliases --rm -p 4000:4000 demo_phoenix_api iex -S mix phx.server
bash:
	docker-compose run --rm demo_phoenix_api bash
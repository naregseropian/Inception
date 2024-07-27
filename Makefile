all: build

build:
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down

fclean: clean
	docker system prune -af

re: fclean all

name = finnews_backend

NO_COLOR=\033[0m	# Color Reset
COLOR_OFF='\e[0m'       # Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow
RED='\e[1;31m'          # Red
GREEN='\e[1;32m'        # Green
YELLOW='\e[1;33m'       # Yellow
BLUE='\e[1;34m'         # Blue
PURPLE='\e[1;35m'       # Purple
CYAN='\e[1;36m'         # Cyan
WHITE='\e[1;37m'        # White
UCYAN='\e[4;36m'        # Cyan

all:
	@printf "$(OK_COLOR)==== Launch configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- __________________________MAIN_________________________"
	@echo -e "$(WARN_COLOR)- make				: Launch configuration"
	@echo -e "$(WARN_COLOR)- make build			: Building configuration"
	@echo -e "$(WARN_COLOR)- make down			: Stopping configuration"
	@echo -e "$(WARN_COLOR)- make ps			: Show configuration containers"
	@echo -e "$(WARN_COLOR)- make re			: Rebuild configuration"
	@echo -e "$(WARN_COLOR)- _______________________LARAVEL_________________________"
	@echo -e "$(WARN_COLOR)- make logs			: Show laravel logs"
	@echo -e "$(WARN_COLOR)- make clr			: Make php optimize:clear"
	@echo -e "$(WARN_COLOR)- make comup			: Do composer update"
	@echo -e "$(WARN_COLOR)- make conn			: Connection to laravel"
	@echo -e "$(WARN_COLOR)- make connroot			: Connection to laravel with root"
	@echo -e "$(WARN_COLOR)- make mv			: Move laravel to laravel_old"
	@echo -e "$(WARN_COLOR)- make opt			: Make php artisan optimize"
	@echo -e "$(WARN_COLOR)- make pull			: Pull updates from git"
	@echo -e "$(WARN_COLOR)- make relar			: Rebuild laravel && php-fpm"
	@echo -e "$(WARN_COLOR)- _____________________WEBSOCKET_________________________"
	@echo -e "$(WARN_COLOR)- make logws			: Show websockets logs"
	@echo -e "$(WARN_COLOR)- make conws			: Connection to websocket"
	@echo -e "$(WARN_COLOR)- make conwsroot		: Connection with root"
	@echo -e "$(WARN_COLOR)- make rews			: Rebuild websockets"
	@echo -e "$(WARN_COLOR)- _________________________NGINX_________________________"
	@echo -e "$(WARN_COLOR)- make logx			: Show nginx logs"
	@echo -e "$(WARN_COLOR)- make conx			: Connection to nginx"
	@echo -e "$(WARN_COLOR)- make conxroot			: Connection with root"
	@echo -e "$(WARN_COLOR)- make rex			: Rebuild nginx"
	@echo -e "$(WARN_COLOR)- _________________________CLEAN_________________________"
	@echo -e "$(WARN_COLOR)- make clean			: Cleaning configuration$(NO_COLOR)"

build:
	@printf "$(OK_COLOR)==== Building configuration ${name}... ====$(NO_COLOR)\n"
	@bash scripts/build.sh
	# @docker-compose -f ./docker-compose.yml up -d --build

clr:
	@printf "$(OK_COLOR)==== Connecting to container ${name}... ====$(NO_COLOR)\n"
	@bash scripts/clear.sh

comup:
	@printf "$(OK_COLOR)==== Do composer update ${name}... ====$(NO_COLOR)\n"
	@bash scripts/update.sh

conn:
	@printf "$(OK_COLOR)==== Connecting to container ${name}... ====$(NO_COLOR)\n"
	@bash scripts/connect.sh

connroot:
	@printf "$(OK_COLOR)==== Connecting with root ${name}... ====$(NO_COLOR)\n"
	@bash scripts/root_connect.sh

conws:
	@printf "$(OK_COLOR)==== Connecting to container ${name}... ====$(NO_COLOR)\n"
	@bash scripts/conws.sh

conwsroot:
	@printf "$(OK_COLOR)==== Connecting with root ${name}... ====$(NO_COLOR)\n"
	@bash scripts/conxroot.sh

conx:
	@printf "$(OK_COLOR)==== Connecting to container ${name}... ====$(NO_COLOR)\n"
	@bash scripts/connx.sh

conxroot:
	@printf "$(OK_COLOR)==== Connecting with root ${name}... ====$(NO_COLOR)\n"
	@bash scripts/root_connect.sh

down:
	@printf "$(ERROR_COLOR)==== Stopping configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down

logs:
	@printf "$(WARN_COLOR)==== Show logs ${name}... ====$(NO_COLOR)\n"
	@bash scripts/logs.sh

logx:
	@printf "$(WARN_COLOR)==== Show logs ${name}... ====$(NO_COLOR)\n"
	@bash scripts/logsx.sh

logws:
	@printf "$(WARN_COLOR)==== Show logs ${name}... ====$(NO_COLOR)\n"
	@bash scripts/logsws.sh

mv:
	@printf "$(WARN_COLOR)==== Show logs ${name}... ====$(NO_COLOR)\n"
	@bash scripts/mv_old.sh


opt:
	@printf "$(BLUE)==== Make optimize for configuration ${name}... ====$(NO_COLOR)\n"
	@bash scripts/optimize.sh

ps:
	@printf "$(BLUE)==== View configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml ps

pull:
	@printf "$(BLUE)==== Pull from repos ${name}... ====$(NO_COLOR)\n"
	@bash scripts/pull.sh

re:	down
	@printf "$(OK_COLOR)==== Rebuild configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build

relar:
	@printf "$(ERROR_COLOR)==== Rebuild websockets ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build laravel

rex:
	@printf "$(ERROR_COLOR)==== Rebuild websockets ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build nginx

rews:
	@printf "$(ERROR_COLOR)==== Rebuild websockets ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build websocket

clean: down
	@printf "$(ERROR_COLOR)==== Cleaning configuration ${name}... ====$(NO_COLOR)\n"
	@docker system prune --a

fclean:
	@printf "$(ERROR_COLOR)==== Total clean of all configurations docker ====$(NO_COLOR)\n"
#	@docker stop $$(docker ps -qa)
#	@docker system prune --all --force --volumes
#	@docker network prune --force
#	@docker volume prune --force
.PHONY	: all build clr comup conn connroot down logs logx logws mv opt ps pull re relar rex rews clean fclean

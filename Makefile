setup:
   docker-compose up --build -d

user:
   docker exec airflow-webserver airflow users create --username karhub --firstname Kar --lastname Hub --role Admin --email karhub@email.com --password karhub
  
run:
   docker-compose up -d

stop:
   docker-compose stop

remove:
   docker-compose down
   docker system prune --volumes -f

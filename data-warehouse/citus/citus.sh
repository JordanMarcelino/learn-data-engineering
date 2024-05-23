# run PostgreSQL with Citus on port 5500
docker run -d --name citus -p 5500:5432 -e POSTGRES_PASSWORD=mypassword citusdata/citus

# connect using psql within the Docker container
docker exec -it citus psql -U postgres
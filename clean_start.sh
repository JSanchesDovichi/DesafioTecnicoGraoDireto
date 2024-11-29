sudo docker rm -f $(sudo docker ps -a -q)
sudo docker system prune -a
sudo docker compose up -d

# reconstruct3d
reconstruct3d_up:
	bash deploy.sh run_reconstruct3d 5040
reconstruct3d_down:
	PORT=5040 docker-compose -f deployment/model_reconstruct3d/docker-compose.yml down

reconstruct3d_restart:
	PORT=5040 docker-compose -f deployment/model_reconstruct3d/docker-compose.yml stop
	PORT=5040 docker-compose -f deployment/model_reconstruct3d/docker-compose.yml start

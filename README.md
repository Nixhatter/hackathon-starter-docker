# hackathon-starter-docker
Dockerfile for the hackathon-starter by sahat

To run:
docker run --name hackathon-starter -d -v /host/volume:/var/www -p 3000:3000 nixhatter/hackathon-starter

You must add your host volume for the container to work. It will grab all your files and sync them to a local copy inside the container. 

While the container is running, it will be looking for changes in the host volume, and if detected, it will re-sync with the internal files.
The only way to re-run npm is to restart the container.

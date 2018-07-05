# CheckMK in docker

Modified xforty's checkmk-docker to add some docker daemon checks, ready to go for rancher system-docker and nfs performance if wanted.

# Running It

docker run \
  --restart=always \
  --detach \
  --name=checkmk \
  --hostname=checkmk \
  --volume=/proc/self/mountstats:/proc/self/mountstats:ro \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=/var/run/system-docker.sock:/var/run/system-docker.sock \
  --label=monitoring=production \
  --publish 6556:6556 \
  nursecurtis/checkmk-docker
  

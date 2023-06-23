import docker
import sys

worker = sys.argv[1]
hostname = sys.argv[2]
address = sys.argv[3]

client = docker.from_env()
for container_name in worker:
    dkg = client.containers.get("exorde"+str(container_name)).logs(stream = True, follow = False, tail=3)
    try:
      while True:
        line = next(dkg).decode("utf-8")
        print(line)
    except StopIteration:
      print(f'log stream ended for {container_name}')




import paramiko


def switch(ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw)
    print("Accessing vps....."+num)
    for i in range(5):
      stdin, stdout, stderr = client.exec_command('docker logs -t --tail=100 exorde'+i)
      stdout=stdout.readlines()
    stdin.close()
    print(stdout)
    print("Successfully")

    
print("Pastikan ip dan password vps benar") 
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(data[0],data[1],data[2])

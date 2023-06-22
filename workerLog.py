import paramiko


def switch(ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw)
    print("Accessing vps.....")
    for i in range(5):
        stdin, stdout, stderr = client.exec_command('docker logs -t --tail=100 exorde'+str(i))
        while True:
            line=stdout.readline()
            if not line:
                brek;
                print(line, end="")
        stdin.close()
        sleep(5)
        
    print("Successfully")

    
print("Pastikan ip dan password vps benar") 
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(data[0],data[1],data[2])

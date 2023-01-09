import paramiko


def switch(num, ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw)
    print("Updatingg....."+num)
    stdin, stdout, stderr = client.exec_command('rm -rf '+num+' && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/'+num+' && chmod 777 '+num)
    stdout=stdout.readlines()
    stdin.close()
    print(stdout)
    print("Successfully")

    
ch = input("Please Enter File Name (exp stuck.sh): ")
        
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(ch, data[0],data[1],data[2])

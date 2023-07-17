import paramiko


def switch(ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw, key_filename='<path/to/openssh-private-key-file>')
    print("Enter all your detail")
    input1 = input("Enter address for workers: ")
    input2 = input("Enter maximum worker do you want: ")
    input3 = input("Install docker? y or n: ")
    input4 = input("Create swap? y or n: ")
    input5 = input("Use Twitter? c (2 core) or d (4 core): ")
    input6 = input("Enter swap do you want with G(exp: 4G): ")
    print("Executing auto run using ssh")
    commandExec = "rm -rf temporaryParam.sh* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/temporaryParam.sh && chmod +x * && bash temporaryParam.sh "+input1+" "+str(input2)+" "+input3+" "+input4+" "+input5+" "+input6
    print(commandExec)
    stdin, stdout, stderr = client.exec_command(commandExec)
    stdout=stdout.readlines()
    stdin.close()
    print(stdout)
    print("Successfully")
        
    
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(data[0],data[1],data[2])

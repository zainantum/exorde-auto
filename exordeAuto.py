import paramiko


def switch(num, ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw)
    stdin, stdout, stderr = client.exec_command('rm -rf additional* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/additional.sh && chmod 777 additional.sh && ./additional.sh')
    if num == "1":
        print("Enter all your detail")
        print("Choose what you want to use:\n 1. Python \n 2. Docker ")
        choice1 = input("Please Enter Your Choice: ")
        stdin, stdout, stderr = client.exec_command('rm -rf autoRunDockerParam* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunDockerParam.sh && chmod 777 autoRunDockerParam.sh && rm -rf autoRunParam* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunParam.sh && chmod 777 autoRunParam.sh')
        input1 = input("Enter address for workers: ")
        input2 = input("Enter maximum worker do you want: ")
        input3 = input("Enter log of worker do you want: ")
        if choice1 == "2":
            input4 = input("Install docker? y or n: ")
        input5 = input("Create swap? y or n: ")
        stdin, stdout, stderr = client.exec_command("./changeAddress.sh "+input1)
        stdin, stdout, stderr = client.exec_command("./changeMaxWorker.sh "+input2)
        stdin, stdout, stderr = client.exec_command("./changeMaxLog.sh "+input3)
        stdin, stdout, stderr = client.exec_command("./changeDockerInstall.sh "+input4)
        stdin, stdout, stderr = client.exec_command("./changeMakeSwap.sh "+input5)
        if input5 == "y":
            input6 = input("Enter swap do you want with G(exp: 4G): ")
            print("Executing command using ssh")
            stdin, stdout, stderr = client.exec_command("./changeMaxSwap.sh "+input6)
        
        print("Executing auto run using ssh")
        if choice1 == "1":
            stdin, stdout, stderr = client.exec_command("./autoRunParam.sh")
        else:
            stdin, stdout, stderr = client.exec_command("./autoRunDockerParam.sh")
        stdout=stdout.readlines()
        stdin.close()
        print(stdout)
        print("Successfully")
    elif num == "2":
        print("Choose what do you use:\n 1. Python \n 2. Docker ")
        choice1 = input("Please Enter Your Choice: ")
        print("Executing updater using ssh")
        if choice1 == "1":
            stdin, stdout, stderr = client.exec_command('rm -rf updaterParam.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/updaterParam.sh && chmod 777 updaterParam.sh')
            stdin, stdout, stderr = client.exec_command("./updaterParam.sh")
            stdout=stdout.readlines()
            stdin.close()
        else:
            stdin, stdout, stderr = client.exec_command('rm -rf updaterDockerParam.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/updaterDockerParam.sh && chmod 777 updaterDockerParam.sh')
            stdin, stdout, stderr = client.exec_command("./updaterDockerParam.sh")
            stdout=stdout.readlines()
            stdin.close()
        print("Successfully")
    elif num == "3":
        print("Choose what do you use:\n 1. Python \n 2. Docker ")
        choice1 = input("Please Enter Your Choice: ")
        chatid = input("Enter your chat id: ")
        stdin, stdout, stderr = client.exec_command("./changeChatId.sh "+chatid)
        print("Executing install send report using ssh")
        if choice1 == "1":
            stdin, stdout, stderr = client.exec_command('rm -rf installReportParam* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/installReportParam.sh && chmod 777 installReportParam.sh')
            stdin, stdout, stderr = client.exec_command('./installReportParam.sh')
            stdout=stdout.readlines()
            stdin.close()
        else:
            stdin, stdout, stderr = client.exec_command('rm -rf updaterParam && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/updaterParam.sh && chmod 777 updaterParam.sh')
            stdin, stdout, stderr = client.exec_command('./sendLogDocker.sh')
            stdout=stdout.readlines()
            stdin.close()
        print("Successfully")
    elif num == "4":
        print("Choose what do you use:\n 1. Python \n 2. Docker ")
        choice1 = input("Please Enter Your Choice: ")
        print("Executing send log using ssh")
        if choice1 == "1":
            stdin, stdout, stderr = client.exec_command('./sendLog.sh')
            stdout=stdout.readlines()
            stdin.close()
        else:
            stdin, stdout, stderr = client.exec_command('./sendLogDocker.sh')
            stdout=stdout.readlines()
            stdin.close()
        print("Successfully")
        
    
print("Choose what you want to do:\n 1. auto-run \n 2. update and reinstall all worker \n 3. install send log \n 4. send log (must be installed send log before)")
choice = input("Please Enter Your Choice: ")
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(choice,data[0],data[1],data[2])

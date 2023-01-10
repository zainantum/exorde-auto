import paramiko


def switch(num, ch1, ch2, ip, un, pw):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, username=un, password=pw)
    print("Updatingg....."+num)
    if num == "1":
            chl = int(ch2)
            if chl>0:
                  for i in range(chl): 
                       stdin, stdout, stderr = client.exec_command(ch1)
            else:
                 stdin, stdout, stderr = client.exec_command(ch1)
            stdout=stdout.readlines()
            stdin.close()
            print(stdout)
            print("Successfully")
    elif num == "2":
            if ch2 == "y":
                        print("Executing... "+ch1)
                        ch2 = " && ./"+ch1
            else:
                 ch2 = ""
            print("Check command "+ch2)
            stdin, stdout, stderr = client.exec_command('rm -rf '+ch1+' && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/'+ch1+' && chmod 777 '+ch1+ch2)
            stdout=stdout.readlines()
            stdin.close()
            print(stdout)
            print("Successfully")
    elif num == "3":
            print("Skipped")

    
print("Choose what you want to do:\n 1. Execute script \n 2. Update and execute script \n 3. skip")
ch = input("Please Enter Your Choice: ")   
if ch == "1":
            cha = input("Please Enter Command: ")   
            chb = input("Looping this command? if yes input max looping, if no input 0 ")
elif ch == "2":
            cha = input("Please Enter Command Do You Want to Update: ")
            chb = input("run script? y or n ")
with open('listIp.txt') as f:
   for line in f:
       data = line.split(";")
       print("Accessing "+str(data[0]))
       switch(ch, cha, chb, data[0],data[1],data[2])

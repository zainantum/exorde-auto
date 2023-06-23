import docker
import sys
import mysql.connector

worker = int(sys.argv[1])
hostname = sys.argv[2]
address = sys.argv[3]

def insertData(ip, db, us, pw, tableName, fieldName, value):
    try:
        connection = mysql.connector.connect(host=ip,
                                            database=db,
                                            user=us,
                                            password=pw)

        mySql_insert_query = """INSERT INTO """+str(tableName)+""" ("""+str(fieldName)+""") 
                            VALUES 
                            ("""+str(value)+""") """
        print(mySql_insert_query)
        cursor = connection.cursor()
        cursor.execute(mySql_insert_query)
        connection.commit()
        # print(cursor.rowcount, "Record inserted successfully into Laptop table")
        cursor.close()

    except mysql.connector.Error as error:
        print("Failed to insert record into Laptop table {}".format(error))

    finally:
        if connection.is_connected():
            connection.close()
            print("MySQL connection is closed")

def getLog(ip, db, us, pw):
    client = docker.from_env()
    for container_name in range(1,worker+1):
        dkg = client.containers.get("exorde"+str(container_name)).logs(stream = True, follow = False, tail=3)
        try:
          while True:
            line = next(dkg).decode("utf-8")
            print(line)
            field = "address, hostname, log, container_id"
            value = "'"+address + "','" + hostname + "','" + line + "','"+"exorde"+str(container_name)+"'"
            insertData(ip, db, us, pw, "tb_d_log", field, value)
        except StopIteration:
          print(f'log stream ended for exorde{container_name}')


with open('listDB.txt') as f:
   for line in f:
       data = line.split(";")
       getLog(data[0],data[1],data[2],data[3])



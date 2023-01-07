import requests
import sys

worker = sys.argv[1]
hostname = sys.argv[2]
#please change you chatID with yours

def send_to_telegram(message):

    apiToken = '5717312084:AAFYl4qrYosNPojHPy6MWZb8W16ab_fR0VI'
    chatID = '461229417'
    apiURL = f'https://api.telegram.org/bot{apiToken}/sendMessage'

    try:
        response = requests.post(apiURL, json={'chat_id': chatID, 'text': message})
        print(response.text)
    except Exception as e:
        print(e)


with open('log1.txt') as f:
    lines = f.readlines()

send_to_telegram("This is a log from server "+hostname+" worker "+worker)
send_to_telegram(lines)

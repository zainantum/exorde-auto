import os
import json, requests
import telebot

bot = telebot.TeleBot("")


def checkrep(address):
    url = 'https://raw.githubusercontent.com/exorde-labs/TestnetProtocol/main/Stats/leaderboard.json'
    resp = requests.get(url)
    loaded = json.loads(resp.text)
    sumrep = 0
    defa = 0
    realrep = 0

    for iterator in loaded:
        sumrep += loaded[iterator]

    for iterator in loaded:
        if str(iterator) == str(address):
            defa = ((loaded[iterator]/sumrep)*100)
            realrep = loaded[iterator]
            break

    textrep = "Reputatuon Detail:\n Total Rep in this iteration: "+str(sumrep)+" \n Your Rep: "+str(realrep)+" \n Percentage: "+str(defa)
    return textrep
  

@bot.message_handler(commands=['start', 'hello'])
def send_welcome(message):
    bot.reply_to(message, "Welcome to Exorde Bot")


@bot.message_handler(commands=['checkrep'])
def sign_handler(message):
    text = "Please input your address:"
    sent_msg = bot.send_message(message.chat.id, text, parse_mode="Markdown")
    bot.register_next_step_handler(sent_msg, day_handler)


def day_handler(message):
    sign = message.text
    text = checkrep(sign)
    sent_msg = bot.send_message(
        message.chat.id, text, parse_mode="Markdown")


@bot.message_handler(func=lambda msg: True)
def echo_all(message):
    bot.reply_to(message, message.text)


bot.infinity_polling()

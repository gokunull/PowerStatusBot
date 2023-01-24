import telebot
import requests
import emoji

url = "ddns_url"
bot = telebot.TeleBot('TOKEN')

@bot.message_handler(content_types=['text'])

def get_text_messages(message):
    if message.text == "Status" or "status":
        bot.send_message(message.from_user.id, curl_request())

def current_status():
    with open('current_status.log') as file:
        status = str(file.readline())
        return status

def curl_request():
    resp = requests.get(url)
    if resp.status_code == 200:
        return "Electricity is available 💡\n" + current_status()
    else:
        return "Electricity isn't available 🔦\n" + current_status()

bot.polling(none_stop=True, interval=0)  

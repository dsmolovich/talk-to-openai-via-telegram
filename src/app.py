import os
import telebot
import openai
import logging

logging.basicConfig(level=logging.INFO)

BOT_TOKEN = os.environ.get('BOT_TOKEN')
bot = telebot.TeleBot(BOT_TOKEN)

@bot.message_handler(func=lambda msg: True)
def reply(message):
    logging.info(f"Received '{message}'")
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=message.text,
        temperature=0.5,
    )
    reply = response.choices[0].text
    bot.reply_to(message, str(reply))
    logging.info(f"Replied '{reply}'")

if __name__ == "__main__":
    logging.info("Starting bot")
    bot.infinity_polling()

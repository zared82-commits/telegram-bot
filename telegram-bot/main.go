
package main

import (
    "log"
    "os"
    "time"

    "gopkg.in/telebot.v3"
    "github.com/joho/godotenv"
)

func main() {
    // Завантаження .env
    err := godotenv.Load()
    if err != nil {
        log.Fatal("Помилка завантаження .env")
    }

    token := os.Getenv("TELE_TOKEN")

    pref := telebot.Settings{
        Token:  token,
        Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
    }

    bot, err := telebot.NewBot(pref)
    if err != nil {
        log.Fatal(err)
    }

    bot.Handle("/start", func(c telebot.Context) error {
        return c.Send("👋 Привіт! Я бот, створений Едуардом Зарембою на Golang.")
    })

    bot.Handle("/info", func(c telebot.Context) error {
        return c.Send("💡 Мене створено для курсу Prometheus DevOps101!")
    })

    log.Println("✅ Бот запущений...")
    bot.Start()
}

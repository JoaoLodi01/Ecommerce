package main

import (
	"context"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	_ "github.com/mattn/go-sqlite3" //

	"go.mau.fi/whatsmeow"
	"go.mau.fi/whatsmeow/store/sqlstore"
	"go.mau.fi/whatsmeow/types/events"
	waLog "go.mau.fi/whatsmeow/util/log"
)

func eventHandler(evt interface{}) {
	switch v := evt.(type) {
	case *events.Message:
		fmt.Println("Mensage recebida!", v.Message.GetConversation())
	}
}

func main() {
	dbLog := waLog.Stdout("DataBase", "DEBUG", true)

	ctx := context.Background()

	container, err := sqlstore.New(ctx, "sqlite3", "file:session.db?_foreign_keys=on", dbLog)

	if err != nil {
		panic(err)
	}

	deviceStore, err := container.GetFirstDevice(ctx)
	if err != nil {
		panic(err)
	}

	client := whatsmeow.NewClient(deviceStore, nil)

	client.AddEventHandler(eventHandler)

	if client.Store.ID == nil {
		qrChan, _ := client.GetQRChannel(context.Background())

		err = client.Connect()

		if err != nil {
			panic(err)
		}

		for evt := range qrChan {
			if evt.Event == "code" {
				fmt.Println("QR Code:", evt.Code)

			} else {
				fmt.Println("Logado: ", evt.Event)

			}
		}
	} else {
		err = client.Connect()
		if err != nil {
			panic(err)
		}

	}

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c

	client.Disconnect()
}

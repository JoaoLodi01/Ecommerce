package core

import (
	"context"

	_ "github.com/mattn/go-sqlite3" //

	"go.mau.fi/whatsmeow"
	"go.mau.fi/whatsmeow/store/sqlstore"
	waLog "go.mau.fi/whatsmeow/util/log"
)

func Login() (string, error) {
	dbLog := waLog.Stdout("DataBase", "DEBUG", true)

	ctx := context.Background()

	container, err := sqlstore.New(ctx, "sqlite3", "file:session.db?_foreign_keys=on", dbLog)
	if err != nil {
		return "", err
	}

	deviceStore, err := container.GetFirstDevice(ctx)
	if err != nil {
		return "", err
	}

	client := whatsmeow.NewClient(deviceStore, nil)

	if client.Store.ID != nil {
		if err := client.Connect(); err != nil {
			return "", err
		}
	}

	qrChan, _ := client.GetQRChannel(ctx)
	if err := client.Connect(); err != nil {
		return "", err
	}

	for {
		select {
		case evt := <-qrChan:
			switch evt.Event {
			case "code":
				return evt.Code, nil

			}

		case <-ctx.Done():
			return "", ctx.Err()
		}
	}
}

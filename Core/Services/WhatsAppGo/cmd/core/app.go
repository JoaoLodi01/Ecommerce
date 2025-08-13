package core

import (
	"context"
	"errors"
	"sync"

	_ "github.com/mattn/go-sqlite3" //
	"google.golang.org/protobuf/proto"

	"go.mau.fi/whatsmeow"
	"go.mau.fi/whatsmeow/store/sqlstore"
	"go.mau.fi/whatsmeow/types"
	waLog "go.mau.fi/whatsmeow/util/log"

	waProto "go.mau.fi/whatsmeow/binary/proto"
)

var (
	clientMu sync.RWMutex
	client   *whatsmeow.Client
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

	c := whatsmeow.NewClient(deviceStore, nil)
	clientMu.Lock()
	client = c
	clientMu.Unlock()

	if c.Store.ID != nil {
		if err := client.Connect(); err != nil {
			return "", err
		}

		return "", nil
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

func IsConnected() bool {
	clientMu.RLock()
	defer clientMu.RUnlock()
	return client != nil && client.IsConnected()

}

func SendText(ctx context.Context, toJID string, text string) (string, error) {
	clientMu.RLock()
	c := client
	clientMu.RUnlock()

	if c == nil {
		return "", errors.New("cliente não inicializado")
	}

	if !c.IsConnected() {
		return "", errors.New("cliente não conectado")
	}

	jid, err := types.ParseJID(toJID)
	if err != nil {
		return "", err
	}

	msg := &waProto.Message{
		Conversation: proto.String(text),
	}

	msgID, err := c.SendMessage(ctx, jid, msg)
	if err != nil {
		return "", err
	}

	return msgID.ID, nil
}

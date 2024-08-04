package main

import (
	"BackFinance/utils"
	"fmt"
	"log"
	"time"

	"github.com/robfig/cron/v3"
)

func SchedulerClearValidateCodeEmail() {
	c := cron.New()
	_, err := c.AddFunc("@every 5m", ClearValidateCodeEmail)
	if err != nil {
		fmt.Println("Erro ao adicionar função ao cron:", err)
		return
	}

	c.Start()
}

func ClearValidateCodeEmail() {
	db, err := utils.ConnectDB()
	if err != nil {
		log.Fatal("Erro no cron:", err)
	}

	res := db.Table(utils.TableCodesEmail).
		Where("tempoduracao < ?", time.Now().UTC().Add(-30*time.Minute)).
		Delete(nil)

	if res.Error != nil {
		log.Fatal("Erro no cron:", err)
	}
}

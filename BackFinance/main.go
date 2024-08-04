package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	routers := ReturnRoutes()

	go SchedulerClearValidateCodeEmail()

	addr := ":9999"
	fmt.Printf("Servidor escutando em %s...\n", addr)
	err := http.ListenAndServe(addr, routers)
	if err != nil {
		log.Fatal("Erro ao iniciar o servidor: ", err)
	}
}

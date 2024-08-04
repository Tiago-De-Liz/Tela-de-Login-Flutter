package main

import (
	"BackFinance/handlers"

	"github.com/gorilla/mux"
)

func ReturnRoutes() *mux.Router {
	router := mux.NewRouter()

	baseRouter := router.PathPrefix("/byteliz").Subrouter()

	baseRouter.HandleFunc("/login", handlers.GETLogin).Methods("GET")
	baseRouter.HandleFunc("/register", handlers.POSTRegister).Methods("PUT")
	baseRouter.HandleFunc("/forgotpassword/email", handlers.POSTForgotPasswordEmail).Methods("POST")
	baseRouter.HandleFunc("/forgotpassword/code", handlers.POSTForgotPasswordCode).Methods("POST")
	baseRouter.HandleFunc("/forgotpassword/newpassword", handlers.POSTForgotPasswordNewPassword).Methods("POST")

	return router
}

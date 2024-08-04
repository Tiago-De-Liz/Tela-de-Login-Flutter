package handlers

import (
	login "BackFinance/login"
	"encoding/json"
	"net/http"
)

func GETLogin(w http.ResponseWriter, r *http.Request) {
	if r.URL.Query().Get("email") != "" {
		if r.URL.Query().Get("password") != "" {
			userId, nome, err := login.VerificarAcessoUsuario(r.URL.Query().Get("email"), r.URL.Query().Get("password"))
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			userOutput := login.UserOutput{
				ID:   userId,
				Nome: nome,
			}

			output, err := json.Marshal(userOutput)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusOK)
			w.Write(output)
			return
		}
		http.Error(w, "Senha não informada!", http.StatusInternalServerError)
		return
	}
	http.Error(w, "E-mail não informado!", http.StatusInternalServerError)
	return
}

func POSTRegister(w http.ResponseWriter, r *http.Request) {
	var novoUsuario login.NewUserInput
	err := json.NewDecoder(r.Body).Decode(&novoUsuario)
	if err != nil {
		http.Error(w, "Erro ao ler JSON: "+err.Error(), http.StatusBadRequest)
		return
	}

	if novoUsuario.Nome != "" {
		if novoUsuario.Email != "" {
			if novoUsuario.Password != "" {
				userID, err := login.RegisterUsuario(novoUsuario)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}

				userOutput := login.UserOutput{
					ID:   userID,
					Nome: novoUsuario.Nome,
				}

				output, err := json.Marshal(userOutput)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}

				w.Header().Set("Content-Type", "application/json")
				w.WriteHeader(http.StatusCreated)
				w.Write(output)
				return
			}
			http.Error(w, "Senha não informada!", http.StatusInternalServerError)
			return
		}
		http.Error(w, "E-mail não informado!", http.StatusInternalServerError)
		return
	}
	http.Error(w, "Nome não informado!", http.StatusInternalServerError)
}

func POSTForgotPasswordEmail(w http.ResponseWriter, r *http.Request) {
	var forgotpassword login.ForgotPasswordEmailInput
	err := json.NewDecoder(r.Body).Decode(&forgotpassword)
	if err != nil {
		http.Error(w, "Erro ao ler JSON: "+err.Error(), http.StatusBadRequest)
		return
	}

	if forgotpassword.Email != "" {
		err := login.GerarCodigoEmailForgotPassword(forgotpassword.Email)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		return
	}
	http.Error(w, "E-mail não informado!", http.StatusInternalServerError)
}

func POSTForgotPasswordCode(w http.ResponseWriter, r *http.Request) {
	var forgotpassword login.ForgotPasswordEmailCodeInput
	err := json.NewDecoder(r.Body).Decode(&forgotpassword)
	if err != nil {
		http.Error(w, "Erro ao ler JSON: "+err.Error(), http.StatusBadRequest)
		return
	}

	if forgotpassword.Email != "" {
		if forgotpassword.Code != "" {
			err := login.ValidarCodigoEmailForgotPassword(forgotpassword.Code, forgotpassword.Email)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusOK)
			return
		}
		http.Error(w, "Código não informado!", http.StatusInternalServerError)
		return
	}
	http.Error(w, "E-mail não informado!", http.StatusInternalServerError)
}

func POSTForgotPasswordNewPassword(w http.ResponseWriter, r *http.Request) {
	var forgotpassword login.ForgotPasswordEmailNewPasswordInput
	err := json.NewDecoder(r.Body).Decode(&forgotpassword)
	if err != nil {
		http.Error(w, "Erro ao ler JSON: "+err.Error(), http.StatusBadRequest)
		return
	}

	if forgotpassword.NewPassword != "" {
		if forgotpassword.Email != "" {
			err = login.AlterarSenhaUsuarioForgotPassword(forgotpassword.Email, forgotpassword.NewPassword)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusOK)
			return
		}
		http.Error(w, "E-mail não informado!", http.StatusInternalServerError)
		return
	}
	http.Error(w, "Nova senha não informado!", http.StatusInternalServerError)
}

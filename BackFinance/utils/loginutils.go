package utils

import (
	"BackFinance/entities"
	"crypto/rand"
	"fmt"
	"math/big"
	"strings"
	"time"

	"golang.org/x/crypto/bcrypt"
	"gopkg.in/mail.v2"
)

const (
	EmailByteLiz = "teste@gmail.com"
	SenhaByteLiz = "teste#"
)

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}

func CompareHashAndPassword(hashedPassword, password string) error {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	if err != nil {
		return err
	}
	return nil
}

func RetornaUsuarioDoEmail(email string) (string, error) {
	db, err := ConnectDB()
	if err != nil {
		return "", fmt.Errorf("Problema de conexão com o servidor: %s", err)
	}

	var usuarios []entities.Usuarios
	res := db.Table(TableUsuarios).
		Where("UPPER(email) = UPPER(?)", email).
		Find(&usuarios)

	if res.Error != nil {
		return "", fmt.Errorf("Problema ao registrar o usuário: %s", res.Error)
	}

	if !(len(usuarios) > 0) {
		return "", nil
	} else {
		for _, usuario := range usuarios {
			return usuario.Id, nil
		}
	}
	return "", nil
}

func EnviarEmailCodigo(email string) error {
	userId, err := RetornaUsuarioDoEmail(email)
	if err != nil {
		return fmt.Errorf("Erro no envio do e-mail do código de validação: %s", err.Error())
	}

	if userId != "" {
		db, err := ConnectDB()
		if err != nil {
			return fmt.Errorf("Erro no envio do e-mail do código de validação: %s", err)
		}

		var codeEmails []entities.Codigosemail
		res := db.Table(TableCodesEmail).
			Where("usuarioid = ?", userId).
			Find(&codeEmails)

		if res.Error != nil {
			return fmt.Errorf("Erro no envio do e-mail do código de validação: %w", res.Error)
		}

		if len(codeEmails) > 0 {
			res = db.Table(TableCodesEmail).
				Delete(&codeEmails)

			if res.Error != nil {
				return fmt.Errorf("Erro no envio do e-mail do código de validação: %s", res.Error)
			}
		}

		code, err := generateRandomCode()
		if err != nil {
			return fmt.Errorf("Erro no envio do e-mail do código de validação")
		}

		var codeEmail entities.Codigosemail = entities.Codigosemail{
			Usuarioid:    userId,
			Codigo:       code,
			Tempoduracao: time.Now().UTC().Add(10 * time.Minute),
		}

		res = db.Table(TableCodesEmail).
			Create(&codeEmail)

		if res.Error != nil {
			return fmt.Errorf("Erro no envio do e-mail do código de validação: %s", res.Error)
		}

		if res.RowsAffected > 0 {
			err = EnviarEmailUsuario(email, "Alterar Senha ByteLiz", fmt.Sprintf("Seu código de validação de alteração de senha é %s", code))
			if err != nil {
				return fmt.Errorf("Erro no envio do e-mail do código de validação: %s", err.Error())
			}

			return nil
		}
	}

	return fmt.Errorf("E-mail informado não foi localizado")
}

func ValidarCodigoEmail(code string, email string) error {
	db, err := ConnectDB()
	if err != nil {
		return fmt.Errorf("Problema de conexão com o servidor: %s", err)
	}

	userId, err := RetornaUsuarioDoEmail(email)
	if err != nil {
		return fmt.Errorf("Problema na validação do código: %s", err.Error())
	}

	if userId != "" {
		var codeEmail []entities.Codigosemail
		res := db.Table(TableCodesEmail).
			Where("usuarioid = ?", userId).
			Where("UPPER(codigo) = UPPER(?)", code).
			Find(&codeEmail)

		if res.Error != nil {
			return fmt.Errorf("Problema na validação do código: %s", res.Error)
		}

		if len(codeEmail) > 0 {
			res = db.Table(TableCodesEmail).
				Delete(&codeEmail)

			if res.Error != nil {
				return fmt.Errorf("Problema na validação do código: %s", res.Error)
			}

			if res.RowsAffected > 0 {
				return nil
			}

			return fmt.Errorf("Código informado inválido")
		}
	}

	return fmt.Errorf("Código informado inválido")
}

func AlterarSenhaUsuario(email, newPassword string) error {
	db, err := ConnectDB()
	if err != nil {
		return fmt.Errorf("Problema de conexão com o servidor: %s", err)
	}

	var usuario entities.Usuarios
	res := db.Table(TableUsuarios).
		Where("UPPER(email) = UPPER(?)", email).
		First(&usuario)

	if res.Error != nil {
		return fmt.Errorf("Problema na alteração de senha: %s", res.Error.Error())
	}

	if usuario.Id == "" {
		return fmt.Errorf("Usuário não localizado para atualização de senha")
	} else {
		err = CompareHashAndPassword(usuario.Senha, newPassword)
		if err != nil {
			hased, err := HashPassword(newPassword)
			if err != nil {
				return fmt.Errorf("Problema na alteração de senha: %s", err.Error)
			}

			res := db.Table(TableUsuarios).
				Where("id = ?", usuario.Id).
				Update("senha", hased)

			if res.Error != nil {
				return fmt.Errorf("Problema na alteração de senha: %s", res.Error)
			}

			if !(res.RowsAffected > 0) {
				return fmt.Errorf("Usuário não localizado para atualização de senha")
			}

			return nil
		}
	}

	return fmt.Errorf("A senha informada não pode ser a mesma")
}

func generateRandomCode() (string, error) {
	const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var sb strings.Builder
	for i := 0; i < 6; i++ {
		num, err := rand.Int(rand.Reader, big.NewInt(int64(len(charset))))
		if err != nil {
			return "", err
		}
		sb.WriteByte(charset[num.Int64()])
	}
	return sb.String(), nil
}

func EnviarEmailUsuario(email, body, title string) error {
	m := mail.NewMessage()
	m.SetHeader("From", EmailByteLiz)
	m.SetHeader("To", email)
	m.SetHeader("Subject", title)
	m.SetBody("text/plain", body)

	d := mail.NewDialer("smtp.gmail.com", 587, EmailByteLiz, SenhaByteLiz)

	if err := d.DialAndSend(m); err != nil {
		return err
	}

	return nil
}

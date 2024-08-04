package login

import (
	"BackFinance/utils"
)

func GerarCodigoEmailForgotPassword(email string) error {
	err := utils.EnviarEmailCodigo(email)
	if err != nil {
		return err
	}

	return nil
}

func ValidarCodigoEmailForgotPassword(code, email string) error {
	err := utils.ValidarCodigoEmail(code, email)
	if err != nil {
		return err
	}

	return nil
}

func AlterarSenhaUsuarioForgotPassword(email, newPassword string) error {
	err := utils.AlterarSenhaUsuario(email, newPassword)
	if err != nil {
		return err
	}

	return nil
}

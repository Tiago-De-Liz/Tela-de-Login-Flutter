package login

import (
	"BackFinance/entities"
	"BackFinance/utils"
	"fmt"
)

func RegisterUsuario(userInput NewUserInput) (string, error) {
	db, err := utils.ConnectDB()
	if err != nil {
		return "", fmt.Errorf("Problema ao registrar o usuário: %s", err)
	}

	hashedPassword, err := utils.HashPassword(userInput.Password)
	if err != nil {
		return "", fmt.Errorf("Problema ao registrar o usuário: %s", err.Error())
	}

	userId, err := utils.RetornaUsuarioDoEmail(userInput.Email)
	if userId != "" {
		return "", fmt.Errorf("O e-mail informado já está cadastrado!")
	}

	var usuario entities.Usuarios = entities.Usuarios{
		Nome:  userInput.Nome,
		Email: userInput.Email,
		Senha: hashedPassword,
		Ativo: "S",
	}
	res := db.Table(utils.TableUsuarios).Create(&usuario)
	if res.Error != nil {
		return "", fmt.Errorf("Problema ao registrar o usuário: %s", res.Error)
	}

	if res.RowsAffected == 0 {
		return "", fmt.Errorf("Problema ao registrar o usuário")
	}

	return usuario.Id, nil
}

package login

import (
	"BackFinance/entities"
	"BackFinance/utils"
	"fmt"
)

func VerificarAcessoUsuario(email, password string) (string, string, error) {
	db, err := utils.ConnectDB()
	if err != nil {
		return "", "", fmt.Errorf("Problema ao verificar os dados de login: %s", err.Error())
	}

	var usuarios []entities.Usuarios
	res := db.Table(utils.TableUsuarios).
		Where("UPPER(email) = UPPER(?)", email).
		Find(&usuarios)
	if res.Error != nil {
		return "", "", fmt.Errorf("Problema ao verificar os dados de login: %s", err.Error())
	}

	if !(len(usuarios) > 0) {
		return "", "", fmt.Errorf("Email ou senha inválidos")
	} else {
		for _, usuario := range usuarios {
			err = utils.CompareHashAndPassword(usuario.Senha, password)
			if err != nil {
				return "", "", fmt.Errorf("Email ou senha inválidos!")
			}

			if usuario.Ativo != "" {
				return usuario.Id, usuario.Nome, nil
			}
		}
	}

	return "", "", fmt.Errorf("Email ou senha inválidos!")
}

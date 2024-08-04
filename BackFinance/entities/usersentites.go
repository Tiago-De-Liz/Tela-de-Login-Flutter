package entities

import (
	"time"
)

type Usuarios struct {
	Id    string `gorm:"type:uuid;default:uuid_generate_v4();primaryKey"`
	Nome  string
	Email string
	Senha string
	Ativo string
}

type Codigosemail struct {
	Id           string `gorm:"type:uuid;default:uuid_generate_v4();primaryKey"`
	Usuarioid    string `gorm:"type:uuid"`
	Codigo       string
	Tempoduracao time.Time `gorm:"type:timestamptz"`
}

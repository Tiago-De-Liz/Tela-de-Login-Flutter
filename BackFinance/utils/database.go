package utils

import (
	"database/sql"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"

	_ "github.com/lib/pq"
)

const (
	sqlMaxIdleConnections = 10
	sqlTimeKillIdle       = 10
	connStr               = "user=postgres password=tiago213 dbname=Byteliz-Finance sslmode=disable"
)

func ConnectDB() (*gorm.DB, error) {
	postdb, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}

	postdb.SetMaxIdleConns(sqlMaxIdleConnections)
	postdb.SetConnMaxLifetime(time.Duration(sqlTimeKillIdle) * time.Minute)

	dialector := &postgres.Dialector{Config: &postgres.Config{Conn: postdb}}
	db, err := gorm.Open(dialector, &gorm.Config{SkipDefaultTransaction: true, Logger: logger.Default.LogMode(logger.Error)})
	if err != nil {
		return nil, err
	}

	return db, nil
}

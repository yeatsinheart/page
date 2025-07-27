package db

import (
	"fmt"
	"log"
	"os"
	"sync"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var (
	db   *gorm.DB
	once sync.Once
)

// Init 初始化数据库连接（只执行一次）
func Init() *gorm.DB {
	once.Do(func() {
		dsn := getDSN()
		var err error
		db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
		if err != nil {
			log.Fatalf("failed to connect to database: %v", err)
		}

		log.Println("✅ MySQL connected")
	})
	return db
}

// GetDB 返回数据库实例
func GetDB() *gorm.DB {
	if db == nil {
		return Init()
	}
	return db
}

// 可根据环境变量或配置文件读取
func getDSN() string {
	user := os.Getenv("DB_USER")
	pass := os.Getenv("DB_PASS")
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	name := os.Getenv("DB_NAME")

	if user == "" {
		user = "root"
		pass = "password"
		host = "127.0.0.1"
		port = "3306"
		name = "testdb"
	}

	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		user, pass, host, port, name)
}

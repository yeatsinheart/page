package main

import (
	"go-demo/db"
	"go-demo/db_user"
	"go-demo/router_user"
)

func main() {
	// 初始化数据库
	//database := db.Init()

	// 自动迁移模型（建表）
	//database.AutoMigrate(&model.User{})

	// 初始化并运行 Gin 路由
	r := router_user.SetupRouter()
	r.Run(":8080") // 启动在 localhost:8080
}

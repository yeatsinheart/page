package db_user

type User struct {
	ID    uint   `gorm:"primaryKey"`
	Name  string
	Email string
}

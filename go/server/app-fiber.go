package main

import "github.com/gofiber/fiber"

type Message struct {
	Message string `json:"Message"`
}

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) {
		message := Message{Message: "Hello World!"}
		// message.Message = "Hello World!"
		c.JSON(message)
	})

	app.Listen(8000)
}

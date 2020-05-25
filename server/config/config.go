package config

import (
	"encoding/json"
	"fmt"
	"os"
)

type Configuration struct {
	Users []string
	Port  string
}

func GetConfiguration(configPath string) Configuration {
	file, _ := os.Open(configPath)
	defer file.Close()
	decoder := json.NewDecoder(file)
	configuration := Configuration{}
	err := decoder.Decode(&configuration)
	if err != nil {
		fmt.Println("error:", err)
	}

	return configuration
}

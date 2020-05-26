package main

import (
	config "cicd/config"
	msg "cicd/message"
	"fmt"
	"net/http"
)

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, msg.GetMessage())
}

func main() {
	const (
		configPath = "/etc/config/server/server.conf"
	)
	config := config.GetConfiguration(configPath)

	http.HandleFunc("/", hello)

	http.ListenAndServe(fmt.Sprintf("0.0.0.0:%s", config.Port), nil)
}

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
		configPath = "/etc/server/server.conf"
	)
	config := config.GetConfiguration(configPath)

	http.HandleFunc("/hello", hello)

	http.ListenAndServe(fmt.Sprintf("localhost:%s", config.Port), nil)
}

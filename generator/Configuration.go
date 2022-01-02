package main

import (
	"io/ioutil"
	"log"

	"gopkg.in/yaml.v3"
)

type config struct {
	DBFilePath string
	HotfixFile string
	Ignored    []int
}

func LoadConfig() config {

	var c config
	yfile, _ := ioutil.ReadFile("config.yml")
	if err := yaml.Unmarshal(yfile, &c); err != nil {
		log.Fatal(err)
	}
	return c
}

package main

import (
	"io/ioutil"
	"log"
)

type FileLoader struct {
	BasePath string
}

func (f FileLoader) Open(fileName string) []byte {
	data, err := ioutil.ReadFile(f.BasePath + fileName)
	if err != nil {
		log.Fatal(err)
	}

	return data
}

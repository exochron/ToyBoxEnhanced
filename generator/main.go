package main

import (
	"io/ioutil"
	"log"
	"tbe_generator/db2reader"
)

func openFile(fileName string) []byte {
	data, err := ioutil.ReadFile(fileName)
	if err != nil {
		log.Fatal(err)
	}

	return data
}

func main() {
	config := LoadConfig()

	hotfix := db2reader.ParseHotfix(openFile(config.HotfixFile))
	toys := collectToys(
		db2reader.ParseDB2(openFile(config.DBFilePath+"toy.db2"), hotfix),
		db2reader.ParseDB2(openFile(config.DBFilePath+"itemsparse.db2"), hotfix),
	)

	for _, ignoreItemId := range config.Ignored {
		delete(toys, ignoreItemId)
	}

	ExportToys(toys)
	ExportTradeable(toys)
}

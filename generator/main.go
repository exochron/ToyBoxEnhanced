package main

import "tbe_generator/db2reader"

func main() {
	config := LoadConfig()

	directFiles := FileLoader{}
	hotfix := db2reader.ParseHotfix(directFiles.Open(config.HotfixFile))

	dbFiles := FileLoader{config.DBFilePath}
	toys := collectToys(
		db2reader.ParseDB2(dbFiles.Open("toy.db2"), hotfix),
		db2reader.ParseDB2(dbFiles.Open("itemsparse.db2"), hotfix),
	)

	for _, ignoreItemId := range config.Ignored {
		delete(toys, ignoreItemId)
	}

	ExportToys(toys)
	ExportTradeable(toys)
}

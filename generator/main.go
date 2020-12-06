package main

func main() {
	config := LoadConfig()

	toys := LoadFromWoWTools("Retail")

	for _, ignoreItemId := range config.Ignored {
		delete(toys, ignoreItemId)
	}

	ExportToys(toys)
}

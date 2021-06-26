package main

func main() {
	config := LoadConfig()

	toys := LoadFromWoWTools("PTR")

	for _, ignoreItemId := range config.Ignored {
		delete(toys, ignoreItemId)
	}

	ExportToys(toys)
}

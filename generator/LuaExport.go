package main

import (
	"log"
	"os"
	"sort"
	"strconv"
)

func (t toy) WriteToFile(file *os.File) {
	file.WriteString("[" + strconv.Itoa(t.ItemID) + "] = true, -- " + t.Name + "\n")
}

func prepareLuaDB(filename string, varname string) *os.File {

	file, err := os.OpenFile("../Database/"+filename, os.O_TRUNC|os.O_WRONLY|os.O_CREATE, 0755)

	if err != nil {
		log.Fatal(err)
	}

	file.WriteString("local _, ADDON = ...\n\n")
	file.WriteString("ADDON.db." + varname + " = {\n")

	return file
}

func getOrderedKeys(list map[int]*toy) []int {
	keys := make([]int, 0, len(list))
	for k := range list {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	return keys
}

func ExportToys(toys map[int]*toy) {
	file := prepareLuaDB("toys.db.lua", "ingameList")
	defer file.Close()

	keys := getOrderedKeys(toys)

	for _, k := range keys {
		toy := toys[k]
		file.WriteString("[" + strconv.Itoa(toy.ItemID) + "] = false, -- " + toy.Name + "\n")
	}

	file.WriteString("}")
}

func ExportTradeable(toys map[int]*toy) {
	file := prepareLuaDB("tradable.db.lua", "Tradable")
	defer file.Close()

	keys := getOrderedKeys(toys)

	for _, k := range keys {
		toy := toys[k]
		if toy.ItemIsTradeable == true {
			toy.WriteToFile(file)
		}
	}

	file.WriteString("}")
}

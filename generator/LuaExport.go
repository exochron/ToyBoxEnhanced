package main

import (
	"log"
	"os"
	"sort"
	"strconv"
)

func (t toy) WriteToFile(file *os.File) {
	file.WriteString("[" + strconv.Itoa(t.ItemID) + "] = false, -- " + t.Name + "\n")
}

func prepareLuaDB(filename string, varname string) *os.File {

	file, err := os.OpenFile("../" + filename, os.O_TRUNC|os.O_WRONLY|os.O_CREATE, 0755)

	if err != nil {
		log.Fatal(err)
	}

	file.WriteString("local ADDON_NAME, ADDON = ...\n\n")
	file.WriteString("ADDON.db." + varname + " = {\n")

	return file
}

func getOrderedKeys(list map[int]toy) []int {
	keys := make([]int, 0, len(list))
	for k := range list {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	return keys
}

func ExportToys(toys map[int]toy) {
	file := prepareLuaDB("toys.db.lua", "ingameList")

	keys := getOrderedKeys(toys)

	for _, k := range keys {
		toy := toys[k]
		toy.WriteToFile(file)
	}

	file.WriteString("}")

	defer file.Close()
}

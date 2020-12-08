package main

import (
	"bytes"
	"encoding/csv"
	"io/ioutil"
	"log"
	"net/http"
	"regexp"
	"strconv"
	"strings"
)

type toy struct {
	ID         int
	ItemID     int
	SourceType int
	SourceText string
	SpellID    int
	Name       string
}

func fetchBuild(branch string) string {
	html := string(request(""))

	reg := regexp.MustCompile(`(?Ui)<td>` + branch + `</td>\s+<td>(.*)</td>`)
	matches := reg.FindStringSubmatch(html)
	if len(matches) > 0 {
		return matches[1]
	}

	log.Fatalln("unknown branch:", branch)
	return ""
}

func request(url string) []byte {
	resp, err := http.Get("https://wow.tools/" + url)
	if err != nil {
		print(err)
	}
	defer resp.Body.Close()

	payload, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		log.Fatal(err)
	}

	return payload
}

func getCSV(table string, build string) map[int]map[string]string {
	url := "dbc/api/export/?name=" + strings.ToLower(table) + "&useHotfixes=true&build=" + build
	data := request(url)
	csvReader := csv.NewReader(bytes.NewReader(data))
	records, err := csvReader.ReadAll()

	if err != nil {
		log.Fatal(err)
	}

	header := records[0]

	results := map[int]map[string]string{}

	for _, row := range records[1:] {

		mapped := map[string]string{}
		for columnNumber, column := range header {
			mapped[column] = row[columnNumber]
		}

		id, _ := strconv.Atoi(mapped["ID"])
		results[id] = mapped
	}

	return results
}

func LoadFromWoWTools(branch string) map[int]toy {

	build := fetchBuild(branch)

	itemsCsv := getCSV("ItemSparse", build)

	toyCsv := getCSV("Toy", build)
	toys := map[int]toy{}
	for _, record := range toyCsv {
		id, _ := strconv.Atoi(record["ID"])
		itemId, _ := strconv.Atoi(record["ItemID"])
		sourceType, _ := strconv.Atoi(record["SourceTypeEnum"])
		name := itemsCsv[itemId]["Display_lang"]

		if name != "" {
			toys[itemId] = toy{
				id,
				itemId,
				sourceType,
				record["SourceText_lang"],
				0,
				name,
			}
		}
	}

	return toys
}

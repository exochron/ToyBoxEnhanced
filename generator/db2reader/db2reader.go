package db2reader

import (
	"log"
)

func ParseDB2(data []byte, hotfix XFTH) wdc3_source {
	format := string(data[:4])
	if format == "WDC3" {

		w := openwdc3(data)
		o := prepareWDC3(w, hotfix)

		return o
	}

	log.Fatal("unknown format: " + format)

	return wdc3_source{}
}

func ParseHotfix(data []byte) XFTH {
	format := string(data[:4])
	if format == "XFTH" {

		return openxfth(data)
	}

	log.Fatal("unknown format: " + format)

	return XFTH{}
}

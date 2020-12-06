package main

type Config struct {
	Ignored []int
}

func LoadConfig() Config {
	return Config{
		Ignored: []int{
			88587, //Iron Belly Spirits
			110586, //Mysterious Flower
			119220, //Alliance Gladiator's Banner
			119221, //Horde Gladiator's Banner
			129111, //Kvaldir Raiding Horn
			130249, //Waywatcher's Boon
			141300, //Magi Focusing Crystal
			143545, //Fel Focusing Crystal
			166851, //Kojo's Master Matching Set
		},
	}
}
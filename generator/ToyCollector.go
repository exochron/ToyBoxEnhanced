package main

type toy struct {
	ID              int
	ItemID          int
	SourceType      int
	SourceText      string
	SpellID         int
	Name            string
	ItemIsTradeable bool
}

func ids_as_map(ids []int32) map[int32]int32 {
	m := make(map[int32]int32, len(ids))
	for _, id := range ids {
		m[id] = id
	}

	return m
}

func collectToys(
	toyDB DBFile,
	itemSparseDB DBFile,
) map[int]*toy {

	sparseIDs := ids_as_map(itemSparseDB.GetIDs())
	toys := map[int]*toy{}
	for _, toyId := range toyDB.GetIDs() {
		itemId := toyDB.ReadInt(toyId, 2)
		sourceType := toyDB.ReadInt(toyId, 4)

		if _, ok := sparseIDs[itemId]; ok {
			toys[int(itemId)] = &toy{
				int(toyId),
				int(itemId),
				int(sourceType),
				toyDB.ReadString(toyId, 0),
				0,
				itemSparseDB.ReadString(itemId, 5),
				itemSparseDB.ReadInt(itemId, 55) == 3, // Bonding is Bind On Use
			}
		}
	}

	return toys
}

type DBFile interface {
	GetIDs() []int32
	ReadInt(id int32, field int, array_index ...int) int32
	ReadInt64(id int32, field int) int64
	ReadString(id int32, field int) string
}

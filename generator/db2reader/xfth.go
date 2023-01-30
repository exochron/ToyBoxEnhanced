package db2reader

// see: https://wowdev.wiki/ADB

type XFTH struct {
	Header xfth_header
	Blocks []xfth_block
}

type xfth_header struct {
	magic    string // 'xfth'
	version  uint32
	build    uint32
	checksum string // sha256
}

func (h *xfth_header) Read(br *ByteReader) {
	h.magic = br.ReadString(4)
	h.version = br.ReadUInt32()
	h.build = br.ReadUInt32()
	if h.version > 4 {
		h.checksum = br.ReadString(32)
	}
}

type xfth_block struct {
	magic       string // xfth
	region_id   uint32
	index       uint32
	table_hash  uint32
	record_id   uint32
	record_size uint32
	unique_id   uint32
	record      []byte
}

func (b *xfth_block) ReadV9(br *ByteReader) {
	b.magic = br.ReadString(4)
	b.region_id = br.ReadUInt32()
	b.index = br.ReadUInt32()
	b.unique_id = br.ReadUInt32()
	b.table_hash = br.ReadUInt32()
	b.record_id = br.ReadUInt32()
	b.record_size = br.ReadUInt32()

	br.ReadUInt32() // some status

	b.record = br.ReadBytes(int(b.record_size))
}

func openxfth(data []byte) XFTH {
	reader := ByteReader{data, 0}
	x := XFTH{}
	x.Header.Read(&reader)

	for int(reader.pointer) < len(data) {
		block := xfth_block{}
		if x.Header.version >= 9 {
			block.ReadV9(&reader)
		}

		x.Blocks = append(x.Blocks, block)
	}

	return x
}

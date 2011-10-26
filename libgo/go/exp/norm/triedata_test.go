// Generated by running
//	maketesttables
// DO NOT EDIT

package norm

var testRunes = []int{1, 12, 127, 128, 256, 2047, 2048, 2457, 65535, 65536, 65793, 1114111, 512, 513, 514, 528, 533}

// testdataValues: 192 entries, 384 bytes
// Block 2 is the null block.
var testdataValues = [192]uint16{
	// Block 0x0, offset 0x0
	0x000c: 0x0001,
	// Block 0x1, offset 0x40
	0x007f: 0x0002,
	// Block 0x2, offset 0x80
}

// testdataSparseOffset: 10 entries, 20 bytes
var testdataSparseOffset = []uint16{0x0, 0x2, 0x4, 0x8, 0xa, 0xc, 0xe, 0x10, 0x12, 0x14}

// testdataSparseValues: 22 entries, 88 bytes
var testdataSparseValues = [22]valueRange{
	// Block 0x0, offset 0x1
	{value: 0x0000, lo: 0x01},
	{value: 0x0003, lo: 0x80, hi: 0x80},
	// Block 0x1, offset 0x2
	{value: 0x0000, lo: 0x01},
	{value: 0x0004, lo: 0x80, hi: 0x80},
	// Block 0x2, offset 0x3
	{value: 0x0001, lo: 0x03},
	{value: 0x000c, lo: 0x80, hi: 0x82},
	{value: 0x000f, lo: 0x90, hi: 0x90},
	{value: 0x0010, lo: 0x95, hi: 0x95},
	// Block 0x3, offset 0x4
	{value: 0x0000, lo: 0x01},
	{value: 0x0005, lo: 0xbf, hi: 0xbf},
	// Block 0x4, offset 0x5
	{value: 0x0000, lo: 0x01},
	{value: 0x0006, lo: 0x80, hi: 0x80},
	// Block 0x5, offset 0x6
	{value: 0x0000, lo: 0x01},
	{value: 0x0007, lo: 0x99, hi: 0x99},
	// Block 0x6, offset 0x7
	{value: 0x0000, lo: 0x01},
	{value: 0x0008, lo: 0xbf, hi: 0xbf},
	// Block 0x7, offset 0x8
	{value: 0x0000, lo: 0x01},
	{value: 0x0009, lo: 0x80, hi: 0x80},
	// Block 0x8, offset 0x9
	{value: 0x0000, lo: 0x01},
	{value: 0x000a, lo: 0x81, hi: 0x81},
	// Block 0x9, offset 0xa
	{value: 0x0000, lo: 0x01},
	{value: 0x000b, lo: 0xbf, hi: 0xbf},
}

// testdataLookup: 640 bytes
// Block 0 is the null block.
var testdataLookup = [640]uint8{
	// Block 0x0, offset 0x0
	// Block 0x1, offset 0x40
	// Block 0x2, offset 0x80
	// Block 0x3, offset 0xc0
	0x0c2: 0x03, 0x0c4: 0x04,
	0x0c8: 0x05,
	0x0df: 0x06,
	0x0e0: 0x04,
	0x0ef: 0x05,
	0x0f0: 0x07, 0x0f4: 0x09,
	// Block 0x4, offset 0x100
	0x120: 0x07, 0x126: 0x08,
	// Block 0x5, offset 0x140
	0x17f: 0x09,
	// Block 0x6, offset 0x180
	0x180: 0x0a, 0x184: 0x0b,
	// Block 0x7, offset 0x1c0
	0x1d0: 0x06,
	// Block 0x8, offset 0x200
	0x23f: 0x0c,
	// Block 0x9, offset 0x240
	0x24f: 0x08,
}

var testdataTrie = trie{testdataLookup[:], testdataValues[:], testdataSparseValues[:], testdataSparseOffset[:], 3}

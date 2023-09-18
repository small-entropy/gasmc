package operation

import (
	"bytes"
	"errors"
)

type Operation struct {
	Instruction []byte
	Value       []byte
}

func (o *Operation) GetOptCode() (byte, error) {
	var err error
	var optCode byte

	var add []byte = []byte{65, 100, 100}
	var sub []byte = []byte{83, 117, 98}
	var mul []byte = []byte{77, 117, 108}
	var div []byte = []byte{68, 105, 118}
	var jmp []byte = []byte{74, 109, 112}
	var jeq []byte = []byte{74, 69, 113}
	var jne []byte = []byte{74, 78, 101}
	var jlt []byte = []byte{74, 76, 116}
	var jgt []byte = []byte{74, 71, 116}
	var push []byte = []byte{80, 117, 115, 104}
	var pop []byte = []byte{80, 111, 112}
	var dup []byte = []byte{68, 117, 112}
	var swap []byte = []byte{83, 119, 97, 112}
	var halt []byte = []byte{72, 97, 108, 116}

	if bytes.Equal(o.Instruction, add) {
		optCode = 0
	} else if bytes.Equal(o.Instruction, sub) {
		optCode = 1
	} else if bytes.Equal(o.Instruction, mul) {
		optCode = 2
	} else if bytes.Equal(o.Instruction, div) {
		optCode = 3
	} else if bytes.Equal(o.Instruction, jmp) {
		optCode = 4
	} else if bytes.Equal(o.Instruction, jeq) {
		optCode = 5
	} else if bytes.Equal(o.Instruction, jne) {
		optCode = 6
	} else if bytes.Equal(o.Instruction, jlt) {
		optCode = 7
	} else if bytes.Equal(o.Instruction, jgt) {
		optCode = 8
	} else if bytes.Equal(o.Instruction, push) {
		optCode = 9
	} else if bytes.Equal(o.Instruction, pop) {
		optCode = 10
	} else if bytes.Equal(o.Instruction, dup) {
		optCode = 11
	} else if bytes.Equal(o.Instruction, swap) {
		optCode = 12
	} else if bytes.Equal(o.Instruction, halt) {
		optCode = 13
	} else {
		err = errors.New("no operation code")
	}

	return optCode, err
}

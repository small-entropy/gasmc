package optcode

type Instruction byte

const (
	OptAdd  Instruction = iota // 1
	OptSub                     // 2
	OptMul                     // 3
	OptDiv                     // 4
	OptJmp                     // 5
	OptJEq                     // 6
	OptJNe                     // 7
	OptJLt                     // 8
	OptJGt                     // 9
	OptPush                    // 10
	OptPop                     // 11
	OptDup                     // 12
	OptSwap                    // 13
	OptHalt                    // 14
)

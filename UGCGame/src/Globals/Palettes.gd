extends Node

var current:int = 0

const melody: = {
	RED = Color("ce6374"), 
	BLUE = Color("5d91d8"), 
	YELLOW = Color("f1de82"), 
	GREEN = Color("6fc453"), 
	PURPLE = Color("7853a7"), 
	ORANGE = Color("f4ae70"), 
	BLACK = Color("4d3347"), 
	WHITE = Color("a3b0bb"), 
	
	BG = Color.white, 
	dark_mode = false, 
	name = "Melody"
}

const pico_8: = {
	RED = Color("FF004D"), 
	BLUE = Color("29ADFF"), 
	YELLOW = Color("FFEC27"), 
	GREEN = Color("008751"), 
	PURPLE = Color("83769C"), 
	ORANGE = Color("FFA300"), 
	BLACK = Color("000000"), 
	WHITE = Color("C2C3C7"), 
	
	BG = Color("FFF1E8"), 
	dark_mode = false, 
	name = "PICO-8"
}

const emblem: = {
	RED = Color("fc2500"), 
	BLUE = Color("0532fa"), 
	YELLOW = Color("faf600"), 
	GREEN = Color("00f300"), 
	PURPLE = Color("9c45fa"), 
	ORANGE = Color("f5a21d"), 
	BLACK = Color("000000"), 
	WHITE = Color("868686"), 
	
	BG = Color("333B4F"), 
	dark_mode = true, 
	name = "Emblem"
}

const slso_clr: = {
	RED = Color("b54131"), 
	BLUE = Color("2aa4aa"), 
	YELLOW = Color("f3c220"), 
	GREEN = Color("56be44"), 
	PURPLE = Color("8f3da7"), 
	ORANGE = Color("c4651c"), 
	BLACK = Color("2e2c3b"), 
	WHITE = Color("c1e5ea"), 
	
	BG = Color("3e415f"), 
	dark_mode = true, 
	name = "SLSO-CLR"
}

const anarkis: = {
	RED = Color("7b133e"), 
	BLUE = Color("3284be"), 
	YELLOW = Color("edb000"), 
	GREEN = Color("008d52"), 
	PURPLE = Color("562f8d"), 
	ORANGE = Color("c8541c"), 
	BLACK = Color("000000"), 
	WHITE = Color("bebeb1"), 
	
	BG = Color("132136"), 
	dark_mode = true, 
	name = "Anarkis"
}


const PALETTE_LIST: = [
	melody, 
	pico_8, 
	emblem, 
	slso_clr, 
	anarkis, 
]

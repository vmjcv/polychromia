extends Node

signal palette_changed
signal colorblind_toggled

const BASE_SIZE:int = 128

const CELL_TYPES: = {
	"START":1, 
	"END":2, 
	"NEGATIVE":3, 
	"WHITEN":4, 
	"RESET":5
}

const SFX_tracks = [
	
	preload("res://UGCGame/assets/sfx/flower_5A.ogg"), 
	preload("res://UGCGame/assets/sfx/flower_5C.ogg"), 
	preload("res://UGCGame/assets/sfx/flower_6C.ogg")
]

const BGM_tracks = [
#	preload("res://UGCGame/assets/bgm/Afternoon Tea.wav"), 
]

const save_file = "user://user_data.sv"
const settings_file = "user://user_sett.sv"

const COLORS: = {
	"RED":{
		"hex":Color("ce6374"), 
		"derived":[], 
	}, 
	"BLUE":{
		"hex":Color("5d91d8"), 
		"derived":[]
	}, 
	"YELLOW":{
		"hex":Color("f1de82"), 
		"derived":[]
	}, 
	"GREEN":{
		"hex":Color("6fc453"), 
		"derived":["YELLOW", "BLUE"]
	}, 
	"PURPLE":{
		"hex":Color("7853a7"), 
		"derived":["BLUE", "RED"]
	}, 
	"ORANGE":{
		"hex":Color("f4ae70"), 
		"derived":["RED", "YELLOW"]
	}, 
	"BLACK":{
		"hex":Color("4d3347"), 
		"derived":[]
	}, 
	"WHITE":{
		"hex":Color("a3b0bb"), 
		"derived":[]
	}, 
}
var BG = Color.white
var dark_mode = false

var current_level: = 0

var settings:Dictionary = {
	bgm = 100, 
	sfx = 100, 
	palette = 0, 
	particles = true, 
	colorblind = false
}

func _ready():
	add_child(load("res://UGCGame/src/ui/Background.tscn").instance())
	load_settings()

func find_derived_color(color, interpolator):
	if not COLORS.has_all([color, interpolator]):
		return color
	
	if color == interpolator or interpolator == "WHITE":
		return color
		
	if color == "WHITE":
		return interpolator
	
	for key in COLORS.keys():
		if COLORS[key].derived.has(color) and COLORS[key].derived.has(interpolator):
			return key
			
	return "BLACK"

func find_negative_color(color):
	if not COLORS.has(color):
		return 
	
	if color == "BLACK":
		return "WHITE"
	if color == "WHITE":
		return "BLACK"
	
	
	if COLORS[color].derived.size():
		for _color in COLORS.keys():
			if not (COLORS[_color].derived.size() or COLORS[color].derived.has(_color)):
				return _color
		return 

	
	for _color in COLORS.keys():
		if COLORS[_color].derived.size() and not COLORS[_color].derived.has(color):
			return _color

func is_valid_color(color):
	return COLORS.has(color)
	
func is_valid_type(type:int):
	return type >= 1 and type <= 5
	
func swap_palette(palette:Dictionary):
	
	for color in COLORS.keys():
		COLORS[color].hex = COLORS[color].hex if not palette.has(color) else palette[color]
	BG = BG if not palette.BG else palette.BG
	dark_mode = not not palette.dark_mode
	emit_signal("palette_changed")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_settings()
		get_tree().quit()

func update_settings(new:Dictionary = {}):
	for key in new.keys():
		settings[key] = new[key]
	if new.has("colorblind"):
		emit_signal("colorblind_toggled")

func save_settings():
	var file = File.new()
	file.open(settings_file, File.WRITE)
	file.store_var(settings)
	file.close()


func load_settings():
	var file = File.new()
	if file.file_exists(settings_file):
		file.open(settings_file, File.READ)
		update_settings(file.get_var(true))
		file.close()
		
	get_node("Background").get_node("CenterContainer/Control/particles").emitting = not not settings.particles
	get_node("Background").get_node("CenterContainer/Control/particles").visible = not not settings.particles
	
	if settings.palette != UGC.autoload.get_autoload("Palettes").current:
		UGC.autoload.get_autoload("Palettes").current = settings.palette
		swap_palette(UGC.autoload.get_autoload("Palettes").PALETTE_LIST[settings.palette])
		
	UGC.autoload.get_autoload("SoundController").set_volume(UGC.autoload.get_autoload("SoundController").bgmPlayer, settings.bgm)
	UGC.autoload.get_autoload("SoundController").set_volume(UGC.autoload.get_autoload("SoundController").sfxPlayer, settings.sfx)

func delete_save_data():
	var dir = Directory.new()
	if dir.file_exists(save_file):
		dir.remove(save_file)
	UGC.autoload.get_autoload("Levels").saved_level_progress = {}
	UGC.autoload.get_autoload("Levels").load_level_data()

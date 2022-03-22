extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	UGC.main.clear_all()
	var main_script = load("res://UGCGame/main.gd").new()
	if main_script.has_method("init_classname"):
		main_script.init_classname()
	if main_script.has_method("init_autoload"):
		main_script.init_autoload()
	UGC.inputmap.load_input()

	if main_script.has_method("init_custom"):
		main_script.init_custom()
	
	var game_scene = "res://UGCGame/main.tscn"
	if main_script.has_method("start_game_scene"):
		game_scene = main_script.start_game_scene()
	get_tree().change_scene(game_scene)

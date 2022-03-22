extends Node

func init_autoload():
	UGC.autoload.add_autoload("Anima",'res://addons/anima/core/anima.gd')
	UGC.autoload.add_autoload("SoundController","res://UGCGame/src/Globals/SoundController.gd")
	UGC.autoload.add_autoload("Palettes","res://UGCGame/src/Globals/Palettes.gd")
	UGC.autoload.add_autoload("Global","res://UGCGame/src/Globals/Global.gd")
	UGC.autoload.add_autoload("Levels","res://UGCGame/src/Globals/Levels.gd")
	pass
	
func start_game_scene():
	return "res://UGCGame/src/ui/Screens/Start.tscn"

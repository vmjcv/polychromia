extends Node

func init_classname():
	UGC.classname.add_classname("AnimaEasing","res://addons/anima/core/easings.gd")
	UGC.classname.add_classname("AnimaNode","res://addons/anima/core/node.gd")
	UGC.classname.add_classname("AnimaNodesProperties","res://addons/anima/utils/node_properties.gd")
	UGC.classname.add_classname("AnimaStrings","res://addons/anima/utils/strings.gd")
	UGC.classname.add_classname("AnimaTween","res://addons/anima/core/tween.gd")


func init_autoload():
	UGC.autoload.add_autoload("Anima",'res://addons/anima/core/anima.gd')
	UGC.autoload.add_autoload("SoundController","res://UGCGame/src/Globals/SoundController.gd")
	UGC.autoload.add_autoload("Palettes","res://UGCGame/src/Globals/Palettes.gd")
	UGC.autoload.add_autoload("Global","res://UGCGame/src/Globals/Global.gd")
	UGC.autoload.add_autoload("Levels","res://UGCGame/src/Globals/Levels.gd")
	pass
	
func init_audio():
	AudioServer.set_bus_layout(load("res://UGCGame/default_bus_layout.tres"))
	
func start_game_scene():
	return "res://UGCGame/src/ui/Screens/Start.tscn"

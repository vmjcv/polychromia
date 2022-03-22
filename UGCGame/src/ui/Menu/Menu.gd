extends Node

onready  var btn_container: = $UI / VBoxContainer
var anima = UGC.autoload.get_autoload("Anima").begin(self)

func _ready():
	anima.then({
		group = $UI, 
		from = 0, 
		to = 1, 
		property = "opacity", 
		duration = 1
	})
	anima.with({
		node = $UI / VBoxContainer, 
		from = $UI / VBoxContainer.rect_position.x + 64, 
		to = $UI / VBoxContainer.rect_position.x, 
		property = "position:x", 
		easing = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT_QUINT, 
		duration = 0.5
	})
	anima.play()
	
#	if not UGC.autoload.get_autoload("SoundController").bgmPlayer.playing:
#		UGC.autoload.get_autoload("SoundController").play_music(UGC.autoload.get_autoload("Global").BGM_tracks[0])
	
	$UI / FLOWER.get_node("animation").play("rotate")
	yield (get_tree().create_timer(0.5), "timeout")
	_on_Btn_hover_position(btn_container.get_node("START").rect_position, btn_container.get_node("START").rect_size)



func _on_Btn_hover_position(pos:Vector2, size:Vector2):
	
	var _position_y = (btn_container.rect_position + pos).y + size.y / 2
	
	if _position_y != $UI / FLOWER.position.y:
		$UI / FLOWER.show_flower(UGC.autoload.get_autoload("Global").BASE_SIZE * 0.5)
		yield (get_tree().create_timer(0.05), "timeout")
		var flower_color = randi() % (UGC.autoload.get_autoload("Global").COLORS.size() - 2)
		var i = 0
		while UGC.autoload.get_autoload("Global").COLORS.values()[flower_color].hex == $UI / FLOWER.base_color and i < 20:
			i += 1
			randomize()
			flower_color = randi() % (UGC.autoload.get_autoload("Global").COLORS.size() - 2)
		$UI / FLOWER.set_color(UGC.autoload.get_autoload("Global").COLORS.values()[flower_color].hex)
		
	$UI / FLOWER.position = Vector2(btn_container.rect_position.x - 32, _position_y)


func _on_Btn_pressed_type(type:String):
	for control in $UI / VBoxContainer.get_children():
		control.disabled = true
	
	if type != "exit":
		anima.clear()
		anima.then({
			group = $UI, 
			to = 0, 
			property = "opacity", 
			duration = 0.5
		})
		anima.play()
		
		yield (anima, "animation_completed")
	
	match type:
		"start":
			get_tree().change_scene("res://UGCGame/src/ui/Level_selection/Level_selection.tscn")
		"settings":
			get_tree().change_scene("res://UGCGame/src/ui/Menu/Settings/Settings.tscn")
		"credits":
			get_tree().change_scene("res://UGCGame/src/ui/Credits/Credits.tscn")
		"exit":
			$UI / FLOWER.hide_flower()
			yield ($UI / FLOWER.anima, "animation_completed")
			get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
		_:
			print_debug(type)
			for control in $UI / VBoxContainer.get_children():
				control.disabled = true

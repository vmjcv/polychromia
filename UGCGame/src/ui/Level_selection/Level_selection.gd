extends Node

onready  var btn_node: = preload("res://UGCGame/src/ui/Btn.tscn")
onready  var lbl_node: = preload("res://UGCGame/src/ui/Menu/Lbl/Lbl.tscn")
onready  var flower_node: = preload("res://UGCGame/src/ui/Flower.tscn")

var anima = UGC.autoload.get_autoload("Anima").begin(self)

const cell_icon = "res://UGCGame/assets/sprites/cell_outline_2.png"
const lock_icon = "res://UGCGame/assets/UI/lock-solid.png"

func _ready():
	var cell_texture = load(cell_icon)
	var lock_texture = load(lock_icon)
	var lock_sprite = Sprite.new()
	lock_sprite.texture = lock_texture
	lock_sprite.modulate = Color.gray if UGC.autoload.get_autoload("Global").dark_mode else Color("55607d")

	for level in range(UGC.autoload.get_autoload("Levels").levels.size()):
		var btn = btn_node.instance()
		btn.change_color = false
		btn.custom_value = str(level)
		$CenterContainer/GridContainer.add_child(btn)
		btn.texture_normal = cell_texture
		btn.connect("btn_pressed", self, "_on_level_selected")
		
		if UGC.autoload.get_autoload("Levels").levels[level].completed:
			var _flower = flower_node.instance()
			_flower.scale = Vector2.ZERO
			btn.add_child(_flower)
			_flower.position = btn.rect_size
			_flower.get_node("animation").play("rotate")
			_flower.set_color(UGC.autoload.get_autoload("Global").COLORS.values()[level % (UGC.autoload.get_autoload("Global").COLORS.size() - 2)].hex)
			_flower.show_flower()
		elif UGC.autoload.get_autoload("Levels").levels[level].locked:
			btn.disabled = true
			var _sprite = lock_sprite.duplicate()
			btn.add_child(_sprite)

			_sprite.position = btn.rect_size
		else :
			var _lbl:Label = lbl_node.instance()
			btn.add_child(_lbl)
			_lbl.text = str(level + 1)
			_lbl.rect_position.y += btn.rect_size.y / 2.0
		

	fade_in()


func _on_Back_btn_pressed():
	fade_out()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")

func _on_level_selected(level:String):
	UGC.autoload.get_autoload("Global").current_level = int(level)
	fade_out()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/Game.tscn")


func fade_in():
	anima.clear()
	anima.then({
		node = self, 
		from = 0, 
		to = 1, 
		property = "opacity", 
		duration = 1, 
		item_delay = 0.2
	})
	anima.play()

func fade_out():
	anima.clear()
	anima.then({
		node = self, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.play()


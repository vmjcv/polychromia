extends Node2D


export  var size:int = UGC.autoload.get_autoload("Global").BASE_SIZE setget set_size, get_size
export  var type:int setget set_type, get_type

onready  var sprite: = $Sprite
onready  var flower: = $FLOWER
onready  var particles: = $particles

var anima = UGC.autoload.get_autoload("Anima").begin(self)


var color:String setget set_color, get_color
var opacity:float = 0.8
var completed:bool setget set_completed, get_completed
var lines:Array = []

func _ready():
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()
	UGC.autoload.get_autoload("Global").connect("colorblind_toggled", self, "_on_colorblind_toggled")
	_on_colorblind_toggled()
	
	particles.process_material = particles.process_material.duplicate(true)
	particles.process_material.color_ramp.gradient.set_color(1, Color.transparent)
	
	set_color("")
	$NEGATIVE.modulate.a = 0.6
	
	flower.get_node("animation").play("rotate")
	

func set_size(_size:int):
	size = _size
	var _scale = float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE
	sprite.scale = Vector2(_scale, _scale)
	$Outline.scale = Vector2(_scale, _scale)
	
	$Colorblind.get_font("font").size = max(24 * float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE, 16)
	$Colorblind.rect_position = Vector2.ONE * (size / 4.0 - $Colorblind.get_font("font").size / 1.2)
	
	$START.scale = Vector2(min(1.5, max(0.5, _scale * 2)), min(1.5, max(0.5, _scale * 2)))
	$NEGATIVE.scale = Vector2(min(1.5, max(0.5, _scale * 2)), min(1.5, max(0.5, _scale * 2)))
	
	$END.scale = Vector2(min(1, max(0.5, _scale * 2)), min(1, max(0.5, _scale * 2)))

func get_size():
	return size
	
func set_type(_type:int):
	type = _type
	
	for t in UGC.autoload.get_autoload("Global").CELL_TYPES.keys():
		if has_node(t):
			get_node(t).visible = false

	for t in UGC.autoload.get_autoload("Global").CELL_TYPES.keys():
		if type == UGC.autoload.get_autoload("Global").CELL_TYPES[t] and has_node(t):
			get_node(t).visible = true
			break
	
	var Global = UGC.autoload.get_autoload("Global")
	match type:
		Global.CELL_TYPES.END:
			flower.visible = true
		Global.CELL_TYPES.NEGATIVE:
			sprite.modulate = Global.COLORS.WHITE.hex.lightened(0.5)
			sprite.modulate.a = opacity

func get_type():
	return type
	
func set_color(_color:String):
	if not UGC.autoload.get_autoload("Global").is_valid_color(_color):
		color = ""
		$Colorblind.text = ""
		sprite.modulate = UGC.autoload.get_autoload("Global").COLORS.WHITE.hex.lightened(0.5) if type == UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE else UGC.autoload.get_autoload("Global").BG
		sprite.modulate.a = opacity
		$START.modulate = UGC.autoload.get_autoload("Global").BG
		$END.modulate = UGC.autoload.get_autoload("Global").BG
		return 
	
	color = _color
	
	sprite.modulate = UGC.autoload.get_autoload("Global").COLORS[color].hex.lightened(0.7)
	sprite.modulate.a = opacity
	
	$START.modulate = UGC.autoload.get_autoload("Global").COLORS[color].hex
	
	$END.modulate = UGC.autoload.get_autoload("Global").COLORS[color].hex
	
	flower.set_color(UGC.autoload.get_autoload("Global").COLORS[color].hex)
	
	particles.process_material.color_ramp.gradient.set_color(0, UGC.autoload.get_autoload("Global").COLORS[color].hex)
	$Colorblind.text = color.substr(0, 1) if color != "BLACK" else ""
	

func get_color():
	return color

func set_completed(_val:bool):
	completed = _val
	$particles.emitting = completed
	
	if completed:
		randomize()
		UGC.autoload.get_autoload("SoundController").play_sound(UGC.autoload.get_autoload("Global").SFX_tracks[randi() % UGC.autoload.get_autoload("Global").SFX_tracks.size()])
		flower.show_flower(size)
	elif type == UGC.autoload.get_autoload("Global").CELL_TYPES.END:
		flower.hide_flower()
	
func get_completed():
	return completed
	



func _on_palette_changed():
	$Outline.visible = UGC.autoload.get_autoload("Global").dark_mode
	opacity = 0.8 if not UGC.autoload.get_autoload("Global").dark_mode else 0.6
	set_color(color)

func _on_colorblind_toggled():
	$Colorblind.visible = not not UGC.autoload.get_autoload("Global").settings.colorblind



func pulse():
	anima.clear()
	anima.then({
		node = sprite, 
		property = "scale", 
		duration = 0.1, 
		to = Vector2.ONE * (float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE - 0.1)
	})
	if $Outline.visible:
		anima.with({
			node = $Outline, 
			property = "scale", 
			duration = 0.1, 
			to = Vector2.ONE * (float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE - 0.1)
		})
	anima.then({
		node = sprite, 
		property = "scale", 
		duration = 0.1, 
		to = Vector2.ONE * float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE, 
	})
	if $Outline.visible:
		anima.with({
			node = $Outline, 
			property = "scale", 
			duration = 0.1, 
			to = Vector2.ONE * float(size) / UGC.autoload.get_autoload("Global").BASE_SIZE, 
		})
	anima.play()

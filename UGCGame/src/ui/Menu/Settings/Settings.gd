extends Node

export  var change_scene_on_exit: = true
signal back_pressed

var anima = UGC.autoload.get_autoload("Anima").begin(self)

var play_sfx_sample: = false

func _ready():
	
	fade_in()
	
	UGC.autoload.get_autoload("Global").connect("palette_changed", self, "_on_palette_changed")
	_on_palette_changed()
	
	$GridContainer / bgm_vol.value = UGC.autoload.get_autoload("Global").settings.bgm
	$GridContainer / sfx_vol.value = UGC.autoload.get_autoload("Global").settings.sfx
	$GridContainer / Particles_toggle.pressed = UGC.autoload.get_autoload("Global").settings.particles
	$GridContainer / Colorblind_toggle.pressed = UGC.autoload.get_autoload("Global").settings.colorblind
	play_sfx_sample = true


func _on_bgm_vol_value_changed(value):
	UGC.autoload.get_autoload("SoundController").set_volume(UGC.autoload.get_autoload("SoundController").bgmPlayer, value)
	
	UGC.autoload.get_autoload("Global").update_settings({bgm = value})

func _on_sfx_vol_value_changed(value):
	UGC.autoload.get_autoload("SoundController").set_volume(UGC.autoload.get_autoload("SoundController").sfxPlayer, value)
	if play_sfx_sample:
		UGC.autoload.get_autoload("SoundController").play_sound(UGC.autoload.get_autoload("Global").SFX_tracks[1])
	
	UGC.autoload.get_autoload("Global").update_settings({sfx = value})

func _on_palette_changed():
	$GridContainer / Palette_options / Lbl.text = UGC.autoload.get_autoload("Palettes").PALETTE_LIST[UGC.autoload.get_autoload("Palettes").current].name
	
	UGC.autoload.get_autoload("Global").update_settings({palette = UGC.autoload.get_autoload("Palettes").current})


func _on_next_palette_pressed():
	UGC.autoload.get_autoload("Palettes").current += 1
	UGC.autoload.get_autoload("Palettes").current = UGC.autoload.get_autoload("Palettes").current if UGC.autoload.get_autoload("Palettes").current < UGC.autoload.get_autoload("Palettes").PALETTE_LIST.size() else 0
	UGC.autoload.get_autoload("Global").swap_palette(UGC.autoload.get_autoload("Palettes").PALETTE_LIST[UGC.autoload.get_autoload("Palettes").current])


func _on_prev_palette_pressed():
	UGC.autoload.get_autoload("Palettes").current -= 1
	UGC.autoload.get_autoload("Palettes").current = UGC.autoload.get_autoload("Palettes").current if UGC.autoload.get_autoload("Palettes").current >= 0 else UGC.autoload.get_autoload("Palettes").PALETTE_LIST.size() - 1
	UGC.autoload.get_autoload("Global").swap_palette(UGC.autoload.get_autoload("Palettes").PALETTE_LIST[UGC.autoload.get_autoload("Palettes").current])

func _on_Back_pressed():
	fade_out()
	yield (anima, "animation_completed")
	if change_scene_on_exit:
		get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")
		return 
	emit_signal("back_pressed")


func _on_Particles_toggled(button_pressed):
	UGC.autoload.get_autoload("Global").get_node("Background").get_node("particles").emitting = button_pressed
	UGC.autoload.get_autoload("Global").get_node("Background").get_node("particles").visible = button_pressed

	UGC.autoload.get_autoload("Global").update_settings({particles = button_pressed})

func _on_Colorblind_toggled(button_pressed):
	UGC.autoload.get_autoload("Global").update_settings({colorblind = button_pressed})


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


func _on_Erase_data_pressed():
	for node in get_children():
		if node.has_method("set_visible"):
			node.visible = false
	$Erase_dialog.visible = true

func _on_erase_answer(type):
	if type == "yes":
		UGC.autoload.get_autoload("Global").delete_save_data()
	for node in get_children():
		if node.has_method("set_visible"):
			node.visible = true
	$Erase_dialog.visible = false

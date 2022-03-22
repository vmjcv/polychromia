extends Node2D

var anima = UGC.autoload.get_autoload("Anima").begin(self)

func _ready():
	$Settings_menu.fade_out()
	$Controller.grid = $Grid
	anima.then({
		node = $UI_elements, 
		property = "opacity", 
		from = 0, 
		to = 1, 
		duration = 1
	})
	anima.play()


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_level_progress()

func save_level_progress():
	var file = File.new()
	var data: = {}
	if file.file_exists(UGC.autoload.get_autoload("Global").save_file):
		file.open(UGC.autoload.get_autoload("Global").save_file, File.READ)
		data = file.get_var(true)
		file.close()
	
	
	var level_progress = {
		lines = [], 
		cells = [], 
		grid_size = $Grid.size
	}
	
	for cell in $Grid.get_node("cells").get_children():
		var cell_data = {
			completed = cell.completed, 
			color = cell.color, 
			type = cell.type, 
			lines = []
		}
		for line in cell.lines:
			cell_data.lines.append(line.get_index())
		
		level_progress.cells.append(cell_data)
	
	for line in $Grid.get_node("lines").get_children():
		var line_data = {
			grid_points = line.grid_points, 
			colors = line.colors, 
			points = line.points, 
			gradient = line.gradient
		}
		
		level_progress.lines.append(line_data)
	
	UGC.autoload.get_autoload("Levels").saved_level_progress[UGC.autoload.get_autoload("Global").current_level] = level_progress
	data.level_progress = UGC.autoload.get_autoload("Levels").saved_level_progress

	file.open(UGC.autoload.get_autoload("Global").save_file, File.WRITE)
	file.store_var(data, true)
	file.close()

func _on_creating_level():
	$UI_elements / Undo.disabled = true
	$UI_elements / Restart.disabled = true
	
	$UI_elements / Lbl.text = str(UGC.autoload.get_autoload("Global").current_level + 1) + " / " + str(UGC.autoload.get_autoload("Levels").levels.size())


func _on_level_creation_finished():
	$UI_elements / Undo.disabled = false
	$UI_elements / Restart.disabled = false


func _on_Home_pressed():
	$Controller.disabled = true
	$UI_elements / Undo.disabled = true
	$UI_elements / Restart.disabled = true
	
	save_level_progress()
	
	anima.clear()
	anima.then({
		node = $Grid, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.with({
		group = $UI_elements, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.play()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Menu/Menu.tscn")


func _on_Settings_pressed():
	$Controller.disabled = true
	$UI_elements.visible = false
	$UI_elements / Settings._on_mouse_exited()
	$Grid.visible = false
	$Settings_menu.visible = true
	$Settings_menu.fade_in()


func _on_Settings_menu_back_pressed():
	$Controller.disabled = false
	$UI_elements.visible = true
	$Grid.visible = true
	$Settings_menu.visible = false


func _on_last_level_completed():
	anima.clear()
	anima.then({
		node = $Grid, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.with({
		group = $UI_elements, 
		property = "opacity", 
		to = 0, 
		duration = 0.5
	})
	anima.play()
	yield (anima, "animation_completed")
	get_tree().change_scene("res://UGCGame/src/ui/Screens/End.tscn")

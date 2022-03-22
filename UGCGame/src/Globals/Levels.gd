extends Node

var levels = [
	{
		grid_size = Vector2.ONE * 3, 
		cells = [
			{
				color = "BLUE", 
				position = Vector2.ZERO, 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				color = "RED", 
				position = Vector2(1, 1), 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				color = "BLUE", 
				position = Vector2(2, 0), 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				color = "RED", 
				position = Vector2(1, 0), 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 4, 
		cells = [
			{
				position = Vector2(2, 2), 
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(1, 2), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 2), 
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 0), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(0, 0), 
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(3, 3), 
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 4, 
		cells = [
			{
				position = Vector2(2, 2), 
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(1, 2), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 2), 
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 0), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(0, 0), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(3, 3), 
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 4, 
		cells = [
			{
				position = Vector2(1, 0), 
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(2, 0), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(0, 0), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 3), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(0, 3), 
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(3, 0), 
				color = "WHITE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(3, 2), 
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 5, 
		cells = [
			{
				position = Vector2(2, 1), 
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(1, 3), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(3, 2), 
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(4, 0), 
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(4, 4), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(2, 4), 
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(1, 4), 
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 5, 
		cells = [
			{
				position = Vector2(4, 0), 
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(4, 1), 
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START
			}, 
			{
				position = Vector2(0, 1), 
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(4, 2), 
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END
			}, 
			{
				position = Vector2(2, 2), 
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE
			}, 
			{
				position = Vector2(4, 3), 
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 6, 
		cells = [
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(2, 2)
			}, 
			{
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(2, 3)
			}, 
			{
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(3, 3)
			}, 
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(3, 2)
			}, 
			{
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(0, 1)
			}, 
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(1, 5)
			}, 
			{
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(5, 4)
			}, 
			{
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(4, 0)
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 6, 
		cells = [
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(1, 0)
			}, 
			{
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(2, 0)
			}, 
			{
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(5, 0)
			}, 
			{
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(2, 5)
			}, 
			{
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(4, 4)
			}, 
			{
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(1, 3)
			}, 
			{
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE, 
				position = Vector2(2, 3)
			}, 
		]
	}, 
	{
		grid_size = Vector2.ONE * 7, 
		cells = [
			{
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE, 
				position = Vector2(3, 1)
			}, 
			{
				color = "", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.NEGATIVE, 
				position = Vector2(3, 5)
			}, 
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(1, 1)
			}, 
			{
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(5, 1)
			}, 
			{
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(4, 3)
			}, 
			{
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(2, 3)
			}, 
			{
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(0, 6)
			}, 
			{
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.START, 
				position = Vector2(6, 6)
			}, 
			{
				color = "BLUE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(0, 5)
			}, 
			{
				color = "GREEN", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(0, 4)
			}, 
			{
				color = "YELLOW", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(3, 3)
			}, 
			{
				color = "RED", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(4, 4)
			}, 
			{
				color = "PURPLE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(1, 2)
			}, 
			{
				color = "ORANGE", 
				type = UGC.autoload.get_autoload("Global").CELL_TYPES.END, 
				position = Vector2(6, 5)
			}, 
		]
	}
]

var saved_level_progress:Dictionary = {}

func _ready():
	load_level_data()

func load_level_data():
	var file = File.new()
	var data: = {}
	if file.file_exists(UGC.autoload.get_autoload("Global").save_file):
		file.open(UGC.autoload.get_autoload("Global").save_file, File.READ)
		data = file.get_var(true)
		file.close()
	
	if data.has("level_progress"):
		saved_level_progress = data.level_progress
	
	for index in levels.size():
		levels[index].completed = data.has("completed_levels") and data.completed_levels.has(index)
		levels[index].locked = not (levels[index].completed
			 or (index and levels[index - 1].completed)
			 or (data.has("unlocked_levels") and data.unlocked_levels.has(index)))
	levels[0].locked = false

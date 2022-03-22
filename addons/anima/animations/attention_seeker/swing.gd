func generate_animation(anima_tween, data: Dictionary) -> void:
	var frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 20, to = 15 },
		{ percentage = 40, to = -10 },
		{ percentage = 60, to = 5 },
		{ percentage = 80, to = -5 },
		{ percentage = 100, to = 0 },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.TOP_CENTER)
	anima_tween.add_frames(data, "rotation", frames)

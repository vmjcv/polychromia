func generate_animation(anima_tween, data: Dictionary) -> void:
	var y_frames = [
		{ percentage = 0, to = 1200 },
		{ percentage = 80, to = -1200 },
		{ percentage = 100, to = 0 },
	]
	
	var scale_frames = [
		{ percentage = 0, from = Vector2(0.7, 0.7) },
		{ percentage = 80, to = Vector2(0.7, 0.7) },
		{ percentage = 100, to = Vector2(1, 1) },
	]

	var opacity_frames = [
		{ percentage = 0, from = 0.7 },
		{ percentage = 80, to = 0.7 },
		{ percentage = 100, to = 1 },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_relative_frames(data, "y", y_frames)
	anima_tween.add_frames(data, "scale", scale_frames)
	anima_tween.add_frames(data, "opacity", opacity_frames)

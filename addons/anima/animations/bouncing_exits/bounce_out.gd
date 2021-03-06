func generate_animation(anima_tween, data: Dictionary) -> void:
	var scale_frames = [
		{ percentage = 0, from = Vector2(1, 1) },
		{ percentage = 20, to = Vector2(0.9, 0.9) },
		{ percentage = 50, to = Vector2(1.1, 1.1) },
		{ percentage = 55, to = Vector2(1.1, 1.1) },
		{ percentage = 100, to = Vector2(0.3, 0.3) },
	]

	var opacity_frames = [
		{ percentage = 0, from = 1 },
		{ percentage = 20, to = 1 },
		{ percentage = 50, to = 1 },
		{ percentage = 55, to = 1 },
		{ percentage = 100, to = 0 },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_frames(data, "scale", scale_frames)
	anima_tween.add_frames(data, "opacity", opacity_frames)

func generate_animation(anima_tween, data: Dictionary) -> void:
	var frames = [
		{ percentage = 0, from = Vector2(1, 1) },
		{ percentage = 14, to = Vector2(1.3, 1.3) },
		{ percentage = 28, to = Vector2(1, 1) },
		{ percentage = 42, to = Vector2(1.3, 1.3) },
		{ percentage = 70, to = Vector2(1, 1) },
		{ percentage = 100, to = Vector2(1, 1) },
	]

	.set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_frames(data, "scale", frames)

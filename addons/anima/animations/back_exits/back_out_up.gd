func generate_animation(anima_tween: AnimaTween, data: Dictionary) -> void:
	var y_frames = [
		{ percentage = 0, to = 0 },
		{ percentage = 20, to = 0 },
		{ percentage = 100, to = 700 },
	]

	var scale_frames = [
		{ percentage = 0, from = Vector2(1, 1) },
		{ percentage = 20, to = Vector2(0.7, 0.7) },
		{ percentage = 100, to = Vector2(0.7, 0.7) },
	]

	var opacity_frames = [
		{ percentage = 0, from = 1 },
		{ percentage = 20, to = 0.7 },
		{ percentage = 100, to = 0.7 },
	]

	AnimaNodesProperties.set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_relative_frames(data, "y", y_frames)
	anima_tween.add_frames(data, "scale", scale_frames)
	anima_tween.add_frames(data, "opacity", opacity_frames)

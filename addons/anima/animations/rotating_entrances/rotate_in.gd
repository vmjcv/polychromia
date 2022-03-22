func generate_animation(anima_tween, data: Dictionary) -> void:
	var opacity_frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 100, to = 1 },
	]

	var rotate_frames = [
		{ percentage = 0, from = 200, pivot = UGC.autoload.get_autoload("Anima").PIVOT.CENTER },
		{ percentage = 100, to = 0 },
	]

	anima_tween.add_frames(data, "opacity", opacity_frames)
	anima_tween.add_frames(data, "rotation", rotate_frames)

func generate_animation(anima_tween, data: Dictionary) -> void:
	var opacity_frames = [
		{ percentage = 0, from = 1 },
		{ percentage = 100, to = 0 },
	]

	var rotate_frames = [
		{ percentage = 0, from = 0, pivot = UGC.autoload.get_autoload("Anima").PIVOT.LEFT_BOTTOM },
		{ percentage = 100, to = 45 },
	]

	anima_tween.add_frames(data, "opacity", opacity_frames)
	anima_tween.add_frames(data, "rotation", rotate_frames)

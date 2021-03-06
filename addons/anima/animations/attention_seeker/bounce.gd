func generate_animation(anima_tween, data: Dictionary) -> void:
	var delay: float = data._wait_time
	var bounce_frames = [
		{ percentage = 0, to = 0 },
		{ percentage = 20, to = 0 },
		{ percentage = 40, to = -30, easing_points = [0.7555, 0.5, 0.8555, 0.06] },
		{ percentage = 43, to = 0, easing_points = [0.7555, 0.5, 0.8555, 0.06] },
		{ percentage = 53, to = +30 },
		{ percentage = 70, to = -15, easing_points = [0.755, 0.05, 0.855, 0.06] },
		{ percentage = 80, to = +15 },
		{ percentage = 90, to = -4 },
		{ percentage = 100, to = +4 },
	]

	var scale_frames = [
		{ percentage = 0, to = 1 },
		{ percentage = 20, to = 1 },
		{ percentage = 40, to = 1.1, easing_points = [0.7555, 0.5, 0.8555, 0.06] },
		{ percentage = 43, to = 1.1, easing_points = [0.7555, 0.5, 0.8555, 0.06] },
		{ percentage = 53, to = 1 },
		{ percentage = 70, to = 1.05, easing_points = [0.755, 0.05, 0.855, 0.06] },
		{ percentage = 80, to = 0.95 },
		{ percentage = 90, to = 1.02 },
		{ percentage = 100, to = 1 },
	]

	anima_tween.add_relative_frames(data, "Y", bounce_frames)
	anima_tween.add_frames(data, "scale:y", scale_frames)

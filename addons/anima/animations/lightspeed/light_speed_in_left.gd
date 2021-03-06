func generate_animation(anima_tween, data: Dictionary) -> void:
	var opacity_frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 60, to = 1 },
	]

	var size = UGC.classname.get_classname("AnimaNodesProperties").get_size(data.node)
	var x_frames = [
		{ percentage = 0, from = -size.x },
		{ percentage = 60, to = size.x },
	]

	var skew_frames = [
		{ percentage = 0, from = 1 },
		{ percentage = 60, to = -0.8 },
		{ percentage = 80, to = 0.16 },
		{ percentage = 100, to = 0, easing = UGC.autoload.get_autoload("Anima").EASING.EASE_OUT_CIRC },
	]

	if data.node is Node2D:
		anima_tween.add_frames(data, "opacity", opacity_frames)
		anima_tween.add_relative_frames(data, "position:x", x_frames)
		anima_tween.add_frames(data, "skew:x", skew_frames)

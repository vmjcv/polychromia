func generate_animation(anima_tween, data: Dictionary) -> void:
	var opacity_frames = [
		{ from = 1, to = 0 },
	]

	var size = UGC.classname.get_classname("AnimaNodesProperties").get_size(data.node)

	var position_frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 100, to = size.x },
	]

	anima_tween.add_relative_frames(data, "x", position_frames)
	anima_tween.add_frames(data, "opacity", opacity_frames)

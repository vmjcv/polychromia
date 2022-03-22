func generate_animation(anima_tween, data: Dictionary) -> void:
	var size = UGC.classname.get_classname("AnimaNodesProperties").get_size(data.node)

	var position_frames = [
		{ percentage = 0, from = 0 },
		{ percentage = 100, to = -size.y },
	]

	anima_tween.add_relative_frames(data, "y", position_frames)

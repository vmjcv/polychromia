func generate_animation(anima_tween, data: Dictionary) -> void:
	var size = UGC.classname.get_classname("AnimaNodesProperties").get_size(data.node)

	var position_frames = [
		{ percentage = 0, from = -size.x },
		{ percentage = 100, to = size.x },
	]

	var rotate_frames = [
		{ from = -120, to = 0 },
	]

	var opacity_frames = [
		{ from = 0, to = 1 },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_frames(data, "opacity", opacity_frames)
	anima_tween.add_frames(data, "rotation", rotate_frames)
	anima_tween.add_relative_frames(data, "x", position_frames)

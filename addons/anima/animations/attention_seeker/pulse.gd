func generate_animation(anima_tween, data: Dictionary) -> void:
	var frames = [
		{ percentage = 0, from = Vector2(1, 1) },
		{ percentage = 50, to = Vector2(1.05, 1.05), easing = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT_SINE },
		{ percentage = 100, to = Vector2(1, 1) },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.CENTER)

	anima_tween.add_frames(data, "scale", frames)

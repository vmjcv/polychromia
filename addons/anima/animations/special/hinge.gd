func generate_animation(anima_tween, data: Dictionary) -> void:
	var position_frames = [
		{ percentage = 0, from = 0, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 80, to = 0, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 100, to = 700, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
	]

	var rotate_frames = [
		{ percentage = 0, from = 0, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 20, to = 80, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 40, to = 60, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 60, to = 80, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 80, to = 60, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
		{ percentage = 100, to = 0, ease = UGC.autoload.get_autoload("Anima").EASING.EASE_IN_OUT },
	]

	var opacity_frames = [
		{ percentage = 0, from = 1 },
		{ percentage = 80, to = 1 },
		{ percentage = 100, to = 0 },
	]

	UGC.classname.get_classname("AnimaNodesProperties").set_2D_pivot(data.node, UGC.autoload.get_autoload("Anima").PIVOT.TOP_LEFT)

	anima_tween.add_frames(data, "opacity", opacity_frames)
	anima_tween.add_frames(data, "rotation", rotate_frames)
	anima_tween.add_relative_frames(data, "y", position_frames)

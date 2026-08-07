extends CanvasLayer

func change_scene(target) -> void:
	$dissolve_rect/AnimationPlayer.play("dissolve")
	#await $dissolve_rect/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$dissolve_rect/AnimationPlayer.play_backwards('dissolve')

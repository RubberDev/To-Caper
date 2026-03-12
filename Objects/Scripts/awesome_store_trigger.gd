extends StaticBody3D



func _on_end_trig_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://Levels/EndScene/end.tscn")
		# Test this
		DirAccess.remove_absolute(body.save_path)

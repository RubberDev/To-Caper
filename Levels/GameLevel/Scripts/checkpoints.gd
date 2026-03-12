extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()

func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()

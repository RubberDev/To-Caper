extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()
		$Checkpoint1.set_deferred("process_mode", PROCESS_MODE_DISABLED)

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()
		$Checkpoint2.set_deferred("process_mode", PROCESS_MODE_DISABLED)

func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()
		$Checkpoint3.set_deferred("process_mode", PROCESS_MODE_DISABLED)

func _on_area_3d_4_body_entered(body: Node3D) -> void:
	if body is Player:
		body.save_check()
		$Checkpoint3.set_deferred("process_mode", PROCESS_MODE_DISABLED)

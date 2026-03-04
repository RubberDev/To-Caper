extends StaticBody3D

var enabled : bool = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if enabled == true:
			$Node/Creak.play()
			enabled = false

func _on_creak_finished() -> void:
	$Node/Break.play()
	$Woodboard.queue_free()

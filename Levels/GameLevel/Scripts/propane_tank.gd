extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("movement")
	$AudioStreamPlayer3D.play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.load_check()

# Play audio when it stops
func _on_audio_stream_player_3d_finished() -> void:
	$AudioStreamPlayer3D.play()

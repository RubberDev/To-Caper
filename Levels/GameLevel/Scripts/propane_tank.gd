extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("movement")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().reload_current_scene()

extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBase/AnimationPlayer.play("Idle")

# Start game level
func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/GameLevel/game_level.tscn")

# Exit game
func _on_quit_button_down() -> void:
	get_tree().quit()

# Show controls
func _on_button_button_down() -> void:
	if $Control/Controls.visible == false:
		$Control/Controls.show()
	elif $Control/Controls.visible == true:
		$Control/Controls.hide()

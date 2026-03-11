extends Node3D

func _ready() -> void:
	$Music.play()
	$AnimationPlayer.play("EndAnim")

func _process(_delta: float) -> void:
	if $AnimationPlayer.is_playing() == false:
		get_tree().change_scene_to_file("res://Levels/MainMenu/menu.tscn")

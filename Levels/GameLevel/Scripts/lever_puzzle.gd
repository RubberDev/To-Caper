extends StaticBody3D

var enabled : bool = false
var On : bool = false

@export var IntText : String = "Press 'e' to interact"

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer2.play("RESET")

func interact():
	if On == false:
		On = true
		$AnimationPlayer.play("pullOn")
		IntText = ""
		$AnimationPlayer2.play("Platform")

extends StaticBody3D

@export var IntText : String = "Press 'E' to interact"
var busy : bool = false

func _ready() -> void:
	$Label3D.hide()

func interact():
	if busy == false:
		busy = true
		$Label3D.show()
		$Timer.start()


func _on_timer_timeout() -> void:
	$Label3D.hide()
	busy = false

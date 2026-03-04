extends StaticBody3D

@export var IntText : String = "Press 'E' to purchase a food truck styled hotdog"
var busy : bool = false

func _ready() -> void:
	$Label3D.hide()

func interact():
	if busy == false:
		$Label3D.show()
		$Timer.start()
		busy = true

func _on_timer_timeout() -> void:
	$Label3D.hide()
	busy = false

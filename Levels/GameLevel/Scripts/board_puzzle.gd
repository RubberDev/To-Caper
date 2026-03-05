extends StaticBody3D

@onready var bridge = $Woodboard
@onready var board = $Woodboard2

@export var IntText : String = "Press 'E' to interact"

func _ready() -> void:
	bridge.hide()
	bridge.set_deferred("process_mode", PROCESS_MODE_DISABLED)

func interact():
	$Place.play()
	board.hide()
	board.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	bridge.show()
	bridge.set_deferred("process_mode", PROCESS_MODE_ALWAYS)
	$CollisionShape3D.set_deferred("disabled", true)

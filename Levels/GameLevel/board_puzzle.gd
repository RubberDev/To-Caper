extends StaticBody3D

@onready var bridge = $Woodboard
@onready var board = $Woodboard2

func _ready() -> void:
	bridge.hide()
	bridge.set_deferred("process_mode", PROCESS_MODE_DISABLED)

func interact():
	board.hide()
	board.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	bridge.show()
	bridge.set_deferred("process_mode", PROCESS_MODE_ALWAYS)
	$CollisionShape3D.set_deferred("disabled", true)

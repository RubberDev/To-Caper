extends Node3D

var disabled : bool = false
@export var value = 1.0

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("spin")

# Handle when player touches money
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if disabled == false:
			disabled = true
			body.money += value
			$Pickup.play()
			self.hide()

# Delete scene when the audio finishes
func _on_pickup_finished() -> void:
	queue_free()

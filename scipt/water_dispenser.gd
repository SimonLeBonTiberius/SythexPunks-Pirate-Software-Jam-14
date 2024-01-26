extends Node
@export var labelNode :Node

var interactible = false
signal water_picked()


# Called when the node enters the scene tree for the first time.
#func _ready():



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$Water_Tank/AnimationPlayer.is_playing():
		$Water_Tank/AnimationPlayer.play("Water_Tank_Idle")
#	pass
func hideInteractionButton(_body):
	labelNode.hide()
	interactible = false
func showInteractionButton(_body):
	labelNode.show()
	interactible = true
func _input(event):
	if event is InputEventKey and event.pressed && interactible:
		
		if event.keycode == KEY_E :
			water_picked.emit()
			$Water_Tank/AnimationPlayer.stop()
			$Water_Tank/AnimationPlayer.play("Water_Tank_Use")

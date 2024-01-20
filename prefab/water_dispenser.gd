extends Node
@export var labelNode :Node

var interactible = false
signal water_picked()


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func hideInteractionButton(body):
	labelNode.hide()
	interactible = false
func showInteractionButton(body):
	labelNode.show()
	interactible = true
func _input(event):
	if event is InputEventKey and event.pressed && interactible:
		
		if event.keycode == KEY_E :
			water_picked.emit()

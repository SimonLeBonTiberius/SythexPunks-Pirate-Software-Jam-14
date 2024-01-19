extends Node
@export var labelNode :Node
@export var seedSpawn :Node
var seed = preload("res://prefab/seed.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func hideInteractionButton(body):
	labelNode.hide()
func showInteractionButton(body):
	labelNode.show()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F && seedSpawn.get_child_count() < 3:
			var instance_seed = seed.instantiate() 
			seedSpawn.add_child(instance_seed)
		if event.keycode == KEY_E && seedSpawn.get_child_count() > 0:
			seedSpawn.get_children()[-1].free() 

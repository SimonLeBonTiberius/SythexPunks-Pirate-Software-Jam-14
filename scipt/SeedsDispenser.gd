extends Node
@export var labelNode :Node
@export var seedSpawn :Node
var seed = preload("res://prefab/seed.tscn")
var interactible = false
signal seed_picked()


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$Seed_Machine/AnimationPlayer.is_playing():
		$Seed_Machine/AnimationPlayer.play("Seed_Machine_Idle")
#	pass
func hideInteractionButton(body):
	labelNode.hide()
	interactible = false
func showInteractionButton(body):
	labelNode.show()
	interactible = true
func _input(event):
	if event is InputEventKey and event.pressed && interactible:
		if event.keycode == KEY_F && seedSpawn.get_child_count() < 3:
			var instance_seed = seed.instantiate() 
			seedSpawn.add_child(instance_seed)
		if event.keycode == KEY_E && seedSpawn.get_child_count() > 0:
			seedSpawn.get_children()[-1].free() 
			seed_picked.emit()
			$Seed_Machine/AnimationPlayer.stop()
			$Seed_Machine/AnimationPlayer.play("Seed_Machine_Use")

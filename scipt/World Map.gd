extends Node3D

var NUM_ROWS = 11
var NUM_COLS = 11

var tile = preload("res://prefab/tile.tscn")
var world_map = []

func _init():
	for r in range(NUM_ROWS):
		var current_row = Node3D.new()
		current_row.set_name("Row " + str(r))
		current_row.set_position(Vector3(-5, 0 , -5 + r))
		add_child(current_row)
		world_map.append([])
		
		for c in range(NUM_COLS):
			var current_tile = tile.instantiate()
			current_tile.set_name("Tile " + str(c))
			current_tile.set_position(Vector3(c, 0, 0))
			current_row.add_child(current_tile)
			world_map[r].append(current_tile)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

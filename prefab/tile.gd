extends Node3D

@export var has_seed: bool
@export var has_water: bool

@export var desert_color: Color
@export var seed_color: Color
@export var water_color: Color
@export var plant_color: Color

var timer: Timer

func set_tile_color(color: Color):
	var mesh: MeshInstance3D = get_node('./StaticBody3D/MeshInstance3D')
	var current_material: Material = mesh.get_active_material(0).duplicate()
	current_material.albedo_color = color
	mesh.set_surface_override_material(0, current_material)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_tile_color(desert_color)
	timer = get_node('./Timer')
	
func set_timer():
	if timer.timeout.is_connected(self.on_timer_timeout):
		timer.timeout.disconnect(self.on_timer_timeout)

	timer.wait_time = 30
	timer.timeout.connect(self.on_timer_timeout)
	timer.start()

func set_seed():
	has_seed = true
	if has_water:
		set_tile_color(plant_color)
	else:
		set_tile_color(seed_color)
	set_timer()

func set_water():
	has_water = true
	if has_seed:
		set_tile_color(plant_color)
	else:
		set_tile_color(water_color)
	set_timer()
	
func on_timer_timeout():
	if has_seed or has_water:
		print("Reverting tile to desert...")
		has_seed = false
		has_water = false
		set_tile_color(desert_color)
		
	timer.timeout.disconnect(self.on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

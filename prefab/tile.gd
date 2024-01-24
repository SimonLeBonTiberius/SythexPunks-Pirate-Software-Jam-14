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
	
func set_variable(variable: String):
	self['has_' + variable] = true
	set_tile_color(self[variable + '_color'])
	timer.wait_time = 30
	timer.connect('timeout', self.on_timer_timout)
	timer.start()

func set_seed():
	set_variable('seed')

func set_water():
	set_variable('water')
	
func on_timer_timeout():
	if has_seed or has_water:
		print("Reverting tile to desert...")
		
		has_seed = false
		has_water = false
		set_tile_color(desert_color)
		
	timer.disconnect('timeout', self.on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_seed and has_water:
		print("Plant growing")
		set_tile_color(plant_color)

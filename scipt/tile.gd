extends Node3D

@export var has_seed: bool
@export var has_water: bool
@export var plant_spawner_node:Node3D
@export var desert_color: Color
@export var seed_color: Color
@export var water_color: Color
@export var plant_color: Color
var arrayplants = []
var plant_1 = preload("res://prefab/plants/plant_1.tscn")
var plant_2 = preload("res://prefab/plants/plant_2.tscn")
var plant_3 = preload("res://prefab/plants/plant_3.tscn")
var plant_4 = preload("res://prefab/plants/plant_4.tscn")
var plant_5 = preload("res://prefab/plants/plant_5.tscn")
var plant_6 = preload("res://prefab/plants/plant_6.tscn")
var plant_7 = preload("res://prefab/plants/plant_7.tscn")
var plant_8 = preload("res://prefab/plants/plant_8.tscn")
var plant_9 = preload("res://prefab/plants/plant_9.tscn")
var plant_10 = preload("res://prefab/plants/plant_10.tscn")
var plant_11 = preload("res://prefab/plants/plant_11.tscn")
var plant_12 = preload("res://prefab/plants/plant_12.tscn")
var plant_13 = preload("res://prefab/plants/plant_13.tscn")
var plant_14 = preload("res://prefab/plants/plant_14.tscn")
var plant_15 = preload("res://prefab/plants/plant_15.tscn")
var plant_16 = preload("res://prefab/plants/plant_16.tscn")


var timer: Timer

func set_tile_color(color: Color,plantIsBorn:bool):
	var mesh: MeshInstance3D = get_node('./StaticBody3D/MeshInstance3D')
	var current_material: Material = mesh.get_active_material(0).duplicate()
	current_material.albedo_color = color
	mesh.set_surface_override_material(0, current_material)
	if plantIsBorn:
		var random = RandomNumberGenerator.new()
		var numberplant  = random.randi_range(1,16)
		var instance_plant = arrayplants[numberplant].instantiate() 
		plant_spawner_node.add_child(instance_plant)
	elif plant_spawner_node.get_child_count() > 0: 
		plant_spawner_node.get_children()[-1].free() 
		
# Called when the node enters the scene tree for the first time.
func _ready():
	arrayplants =[plant_1,plant_2,plant_3,plant_4,plant_5,plant_6,plant_7,plant_8,plant_9,plant_10,plant_11,plant_12,plant_13,plant_14,plant_15,plant_16]
	set_tile_color(desert_color, false)
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
		set_tile_color(plant_color,true)
	else:
		set_tile_color(seed_color,false)
	set_timer()

func set_water():
	has_water = true
	if has_seed:
		set_tile_color(plant_color,true)
	else:
		set_tile_color(water_color,false)
	set_timer()
	
func on_timer_timeout():
	if has_seed or has_water:
		print("Reverting tile to desert...")
		has_seed = false
		has_water = false
		set_tile_color(desert_color,false)
		
	timer.timeout.disconnect(self.on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

extends CharacterBody3D


const SPEED = 4.0
const JUMP_VELOCITY = 6.0
const MOUSE_SENSITIVITY = 0.002
@export var  body: Node3D
@export var lbl_water: Label3D
@export var lbl_seeds: Label3D
@export var lbl_give_water: Label3D
@export var lbl_plant: Label3D
var counter_water = 0
var counter_seeds = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	var node_seed_dispenser_list = get_tree().get_nodes_in_group("seed_dispenser")
	var node_water_dispenser_list = get_tree().get_nodes_in_group("water_dispenser")
	lbl_give_water.hide()
	lbl_plant.hide()
	if node_seed_dispenser_list:
		var node_seed_dispenser = node_seed_dispenser_list[0]
		node_seed_dispenser.connect('seed_picked',addSeeds)
	if node_water_dispenser_list:
		var node_water_dispenser = node_water_dispenser_list[0]
		node_water_dispenser.connect('water_picked',addWater)


func checklblplant() -> bool:
	return counter_seeds>0
func checklblwater()-> bool:
	return counter_water>0

func addSeeds():
	counter_seeds +=1
	lbl_seeds.set_text(str(counter_seeds))
	if (checklblplant()):
		lbl_plant.show()
	else: 
		lbl_plant.hide()
	
func addWater():
	counter_water +=1
	lbl_water.set_text(str(counter_water))
	if (checklblwater()):
		lbl_give_water.show()
	else: 
		lbl_give_water.hide()
	
func useSeeds():
	counter_seeds -=1
	lbl_seeds.set_text(str(counter_seeds))
	if (checklblplant()):
		lbl_plant.show()
	else: 
		lbl_plant.hide()
	
func useWater():
	counter_water -=1
	lbl_water.set_text(str(counter_water))
	if (checklblwater()):
		lbl_give_water.show()
	else: 
		lbl_give_water.hide()
	
func check_collision_with_tiles():
	for i in get_slide_collision_count():
		var collision: KinematicCollision3D = get_slide_collision(i)
		var collidervar= collision.get_collider()
		var booleval = collidervar.is_in_group('tiles')
		if(booleval):#collidervar.is_in_group('tiles')):
			var mesh: MeshInstance3D = collision.get_collider().get_node("MeshInstance3D")
			var current_material = mesh.get_active_material(0).duplicate()
			current_material.albedo_color = Color("5ca904")
			mesh.set_surface_override_material(0, current_material)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_back")
	if Input.is_action_pressed("move_forward"):
		body.set_rotation_degrees(Vector3(0, 0, 0))
	if Input.is_action_pressed("strafe_left"):
		body.set_rotation_degrees(Vector3(0, 90, 0))
	if Input.is_action_pressed("strafe_right"):
		body.set_rotation_degrees(Vector3(0, -90, 0))
	if Input.is_action_pressed("move_back"):
		body.set_rotation_degrees(Vector3(0, -180, 0))
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()
	
	# Check collision with tiles
	# check_collision_with_tiles()

func set_variable(variable: String):
	for i in get_slide_collision_count():
			var collision: KinematicCollision3D = get_slide_collision(i)
			var collider: Object = collision.get_collider()
			if collider.is_in_group('tiles'):
				if variable == 'seed':
					collider.get_parent().set_seed()
				elif variable == 'water':
					collider.get_parent().set_water()

func _process(_delta):
	if Input.is_action_just_pressed("plant_seed_debug"):
		print("Pressed plant_seed_debug")
		set_variable('seed')

	elif Input.is_action_just_pressed("drop_water_debug"):
		print("Pressed drop_water_debug")
		set_variable('water')
		
func _input(event):
	if event is InputEventKey and event.pressed:
		
		if event.keycode == KEY_X :
			pass


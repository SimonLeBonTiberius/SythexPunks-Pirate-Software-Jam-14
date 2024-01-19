extends CharacterBody3D


const SPEED = 4.0
const JUMP_VELOCITY = 6.0
const MOUSE_SENSITIVITY = 0.002
@export var  body: Node3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
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
		body.set_rotation_degrees (Vector3(0, 0, 0))
	if Input.is_action_pressed("strafe_left"):
		body.set_rotation_degrees (Vector3(0,90 , 0))
	if Input.is_action_pressed("strafe_right"):
		body.set_rotation_degrees (Vector3(0,-90 , 0))
	if Input.is_action_pressed("move_back"):
		body.set_rotation_degrees (Vector3(0,-180 , 0))
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()
	# Check collision with tiles
	for i in get_slide_collision_count():
		var collision: KinematicCollision3D = get_slide_collision(i)
		var collidervar= collision.get_collider()
		if(true):#collidervar.is_in_group('tiles')):
			var mesh: MeshInstance3D = collision.get_collider().get_node("MeshInstance3D")
			var current_material = mesh.get_active_material(0).duplicate()
			current_material.albedo_color = Color("5ca904")
			mesh.set_surface_override_material(0, current_material)

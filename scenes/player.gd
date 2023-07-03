extends CharacterBody2D

signal landed

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var grounded = false
func _input(event):
	if event.is_action("move"):
		move(Input.get_axis("left", "right"))
	if Input.is_action_pressed("jump") and is_on_floor():
		jump()

func _physics_process(delta):
	# Add the gravity.
	ground_check(delta) 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func jump():
	velocity.y = JUMP_VELOCITY
	$AnimatedSprite2D.play("jump")
		
func move(dir):
	direction = dir
	if dir == 0:
		$AnimatedSprite2D.play ("idle")
	else:
		$AnimatedSprite2D.play("walk")
	$AnimatedSprite2D.flip_h = dir < 0

func ground_check(delta):
	var was_grounded = grounded
	grounded = is_on_floor()
	if not grounded:
		velocity.y += gravity * delta
	elif not was_grounded:
		landed.emit()

func land():
	if direction == 0:
		$AnimatedSprite2D.play("walk")


func jump_finished():
	if grounded:
		$AnimatedSprite2D.play ("idle")
	else:
		$AnimatedSprite2D.play("fall")

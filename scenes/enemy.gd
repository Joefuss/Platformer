extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var direction = 1
@export var speed = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if direction ==1:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = true 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if direction == 1:
		velocity.x = -speed
	else:
		velocity.x = speed
	if not is_on_floor():
		velocity.y += gravity * delta	

	move_and_slide()

func _on_edge_marker_body_entered(body):
	if direction == 1:
		direction = -1
	else:
		direction = 1

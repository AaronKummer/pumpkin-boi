extends CharacterBody2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var sprite: Sprite2D = get_node("Sprite2D")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update_animation():
	if velocity.x > 0: # Moving right
		sprite.flip_h = false
		animation_player.play("walk-right")
	elif velocity.x < 0: # Moving left
		sprite.flip_h = true
		animation_player.play("walk-right")
	else:
		animation_player.stop() # Stop the animation if not moving



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation()
	move_and_slide()

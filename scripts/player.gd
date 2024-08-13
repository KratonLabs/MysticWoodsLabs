class_name Player extends CharacterBody2D

## Movement speed of the player in pixels per second
const speed = 100

## Tracks the current direction the player is facing
var current_dir = "none"

## Called when the node enters the scene tree for the first time
func _ready():
	# Play the idle animation for the front-facing direction when the game starts
	$AnimatedSprite2D.play("front_idle")

## Called every frame, specifically for handling physics-related updates
## 'delta' is the time elapsed since the previous frame, used to make movement frame-rate independent
func _physics_process(delta):
	player_movement(delta)

## Handles player movement and direction based on user input.
## [codeblock]
## Parameters:
##   delta (float): The time elapsed since the last frame, used to make movement frame-rate independent.
## [/codeblock]
## This function checks for directional input (up, down, left, right) and updates the player's
## velocity and direction accordingly. It also triggers the appropriate animation for the player's
## movement or idle state. The player is moved using the `move_and_slide` function, which allows
## for smooth and collision-aware movement.
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"  # Update the direction to right
		play_anim(1)  # Play the walking animation for right movement
		velocity.x = speed  # Set horizontal speed
		velocity.y = 0  # No vertical movement when moving right
	
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"  # Update the direction to left
		play_anim(1)  # Play the walking animation for left movement
		velocity.x = -speed  # Set horizontal speed in the opposite direction
		velocity.y = 0  # No vertical movement when moving left
	
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"  # Update the direction to down
		play_anim(1)  # Play the walking animation for downward movement
		velocity.x = 0  # No horizontal movement when moving down
		velocity.y = speed  # Set vertical speed
	
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"  # Update the direction to up
		play_anim(1)  # Play the walking animation for upward movement
		velocity.x = 0  # No horizontal movement when moving up
		velocity.y = -speed  # Set vertical speed in the opposite direction
	
	else:
		play_anim(0)  # Play the idle animation when no movement input is detected
		velocity.x = 0  # Stop horizontal movement
		velocity.y = 0  # Stop vertical movement
	
	# Apply the calculated velocity to move the player.
	# move_and_slide handles collisions and allows the player to slide along surfaces.
	move_and_slide()


## Plays the appropriate animation based on the player's current direction and 
## movement state.
## [br][br]
## Parameters:
## [codeblock]
## movement (int): Determines whether the player is moving or idle.
##                   - 1 indicates the player is moving.
##                   - 0 indicates the player is idle.
## [/codeblock]
## [br]
## This function selects the animation to play based on the player's current direction.
## The sprite is also flipped horizontally when facing left, ensuring the player appears
## to move in the correct direction on the screen.
func play_anim(movement):
	var dir = current_dir  # Store the current direction of the player
	var anim = $AnimatedSprite2D  # Reference to the player's animated sprite
	
	if dir == "right":
		anim.flip_h = false  # Ensure the sprite is facing right
		if movement == 1:
			anim.play("side_walk")  # Play the walking animation for right movement
		elif movement == 0:
			anim.play("side_idle")  # Play the idle animation when stationary facing right

	elif dir == "left":
		anim.flip_h = true  # Flip the sprite horizontally to face left
		if movement == 1:
			anim.play("side_walk")  # Play the walking animation for left movement
		elif movement == 0:
			anim.play("side_idle")  # Play the idle animation when stationary facing left

	elif dir == "down":
		anim.flip_h = false  # Ensure the sprite is not flipped
		if movement == 1:
			anim.play("front_walk")  # Play the walking animation for downward movement
		elif movement == 0:
			anim.play("front_idle")  # Play the idle animation when stationary facing downward

	elif dir == "up":
		anim.flip_h = false  # Ensure the sprite is not flipped
		if movement == 1:
			anim.play("back_walk")  # Play the walking animation for upward movement
		elif movement == 0:
			anim.play("back_idle")  # Play the idle animation when stationary facing upward


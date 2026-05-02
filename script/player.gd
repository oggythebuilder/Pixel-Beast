extends CharacterBody2D

# --- Variables and Configuration ---

# Constant values for movement physics
const SPEED = 850.0  # Pixels per second
const JUMP_VELOCITY = -1000.0  # Upward velocity when jumping
const ATTACK_MOVEMENT_LOCK_DURATION = 0.3 # Time movement is disabled during attack

# Pre-fetch node references from the scene structure shown in your image
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var footstep_sound: AudioStreamPlayer2D = $FootstepSound
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2



# Get gravity setting from Project Settings (standard 2D platformer value)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# State tracking variables
var is_attacking = false
var facing_direction = 1 # 1 = right, -1 = left

func _physics_process(delta):
	# --- Attack State Lock ---
	# If we are attacking, disable all other input and keep moving only vertically (due to gravity).
	if is_attacking:
		# Add gravity if attacked while in air (rare but possible).
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()
		return

	# --- Gravity ---
	# Add gravity every frame if the character is not on the floor.
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- Jumping ---
	# Use the custom "jump" input action we set up.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# --- Attack Input ---
	# Use the custom "attack" input action we set up.
	if Input.is_action_just_pressed("attack") and is_on_floor():
		perform_attack()
		return # Stop processing this frame to prevent animation issues

	# --- Directional Movement ---
	# Read directional input from left/right keys.
	var direction = Input.get_axis("ui_left", "ui_right")

	# Update state and sprite flip based on direction.
	if direction:
		facing_direction = direction
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		# use move_toward for smooth stopping.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply final velocities to move the body.
	move_and_slide()

	# Update the correct animation after physics are done.
	update_animations()

# --- Functions ---

func update_animations():
	if not is_on_floor():
		# Play the jump animation if in the air.
		animated_sprite_2d.play("Jump")
		footstep_sound.stop() # Hawa mein footstep sound band kar do
		
	elif velocity.x != 0:
		# Play the run animation if moving horizontally.
		animated_sprite_2d.play("Run")
		
		# Sound tabhi play karo jab wo pehle se na chal raha ho
		if not footstep_sound.playing:
			footstep_sound.play()
			
	else:
		# Play the idle animation if standing still.
		animated_sprite_2d.play("Idle")
		footstep_sound.stop() # sound

func perform_attack():
	is_attacking = true
	velocity.x = 0  # Horizontal movement rok do

	animated_sprite_2d.play("attack")
	if not audio_stream_player_2d_2.playing:
			audio_stream_player_2d_2.play()
	# Check karo Hitbox ke andar kaun kaun hai
	var overlapping_bodies = attack_hitbox.get_overlapping_bodies()
	for body in overlapping_bodies:
		# Agar body ke paas take_damage function hai (yani wo enemy hai) aur wo player khud nahi hai
		if body.has_method("take_damage") and body != self:
			body.take_damage()

	# Animation khatam hone ka wait karo
	await animated_sprite_2d.animation_finished

	is_attacking = false
# Optional: Function to reset state if needed (e.g., when scene changes or player spawns)
func reset_state():
	is_attacking = false
	velocity = Vector2.ZERO


var health = 100

func take_damage():
	health -= 5 # या जो भी अमाउंट आप कम करना चाहते थे
	print("Player Health: ", health) # आउटपुट में हेल्थ देखने के लिए
	
	if health <= 0:
		die()

func die():
	# प्लेयर के मरने पर सीन को रीस्टार्ट करना
	get_tree().reload_current_scene()

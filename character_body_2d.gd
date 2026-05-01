extends CharacterBody2D

# --- Configuration ---
@export var speed =120.0
@export var max_health = 15 # Boss ki health zyada hoti hai
var health = max_health

# --- Variables ---
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null
var is_attacking = false
var is_dead = false

# --- Nodes ---
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_hitbox: Area2D = $BossHitbox
@onready var attack_range: Area2D = $AttackRange
@onready var diee_1: AudioStreamPlayer2D = $diee1
@onready var timer: Timer = $Timer

func _physics_process(delta):
	# Agar boss mar chuka hai, toh kuch mat karo
	if is_dead:
		return

	# Gravity apply karna
	if not is_on_floor():
		velocity.y += gravity * delta

	# Player ko chase karna (Agar player detect ho gaya hai aur attack nahi kar raha)
	if player and not is_attacking:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		
		animated_sprite_2d.play("run")
		# Sprite ko player ki taraf ghumana
		animated_sprite_2d.flip_h = direction.x < 0
	elif not is_attacking:
		velocity.x = move_toward(velocity.x, 0, speed)
		animated_sprite_2d.play("idle")

	move_and_slide()

# 1. Jab Player Boss ke ilake (AggroArea) me aaye
func _on_aggro_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_dead:
		player = body # Boss ne player ko dekh liya, ab chase shuru!

# (Optional) Jab Player door chala jaye, boss wapas idle ho jaye
func _on_aggro_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null

# 2. Jab Player pass aa jaye (AttackRange me)
func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_attacking and not is_dead:
		perform_boss_attack()

func perform_boss_attack():
	is_attacking = true
	velocity.x = 0 # Attack karte waqt boss ruk jayega

	# Randomly 2 me se 1 attack choose karo (0 ya 1)
	var random_attack = randi() % 70
	
	if random_attack == 0:
		animated_sprite_2d.play("attack_1")
	else:
		animated_sprite_2d.play("attack_2")

	# Damage calculation (Thoda wait karte hain taki animation middle me pahuche tab damage lage)
	await get_tree().create_timer(0.4).timeout 
	
	# Check karo ki BossHitbox me player hai ya nahi
	if not is_dead:
		var overlapping_bodies = boss_hitbox.get_overlapping_bodies()
		for body in overlapping_bodies:
			if body.is_in_group("player") and body.has_method("take_damage"):
				body.take_damage()

	# Wait for animation to finish
	await animated_sprite_2d.animation_finished
	
	# Cooldown: Boss turant attack nahi karega, thoda saans lega (0.8 seconds)
	if not is_dead:
		animated_sprite_2d.play("idle")
		await get_tree().create_timer(0.5).timeout
	if not diee_1.playing:
			diee_1.play()
	is_attacking = false

# 3. Boss ko damage milna
func take_damage():
	if is_dead:
		return
		
	health -= 1
	print("Boss Health: ", health)
	
	if health <= 0:
		die()

# 4. Boss ka marna
func die():
	is_dead = true
	velocity = Vector2.ZERO # Move hona band
	is_attacking = false
	
	# Death animation play karo aur wait karo
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	
	# Scene se delete kar do
	queue_free()


func _on_boss_hitbox_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass # Replace with function body.

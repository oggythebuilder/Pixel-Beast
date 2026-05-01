extends CharacterBody2D

@export var speed = 150.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $AttackRange/RayCast2D





var health = 2
var player = null
var is_attacking = false
var is_dead = false # Naya variable

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Gravity hamesha apply karo
	if not is_on_floor():
		velocity.y += gravity * delta

	# Agar dead hai toh movement aur attack rok do
	if is_dead:
		move_and_slide()
		return

	# RayCast se player detect karna 
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider and collider.is_in_group("player"): 
			player = collider
	
	if player and not is_attacking:
		var direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		
		animated_sprite_2d.play("run")
		animated_sprite_2d.flip_h = direction.x < 0
	else:
		velocity.x = 0
		if not is_attacking:
			animated_sprite_2d.play("idle")

	move_and_slide()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_attacking and not is_dead:
		attack_player(body)

func attack_player(target):
	is_attacking = true
	animated_sprite_2d.play("attack") 
	
	if target.has_method("take_damage"):
		target.take_damage()
	
	await animated_sprite_2d.animation_finished
	is_attacking = false

func take_damage():
	if is_dead:
		return
		
	health -= 2
	print("Enemy Health: ", health)
	
	if health <= 0: 
		die()

func die():
	is_dead = true
	velocity.x = 0 
	
	animated_sprite_2d.play("die") # Make sure animation ka naam bilkul yahi ho

	await animated_sprite_2d.animation_finished
	queue_free()

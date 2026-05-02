extends CharacterBody2D

# --- Variables ---
@export var speed = 350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null
var is_dead = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ti: AudioStreamPlayer2D = $ti




func _ready():
	# Jaise hi kida paida hoga, wo player ko dhoondh lega
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	
	animated_sprite_2d.play("run")

func _physics_process(delta):
	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Kida hamesha player ki taraf bhagega
	if player:
		var direction = sign(player.global_position.x - global_position.x)
		velocity.x = direction * speed
		animated_sprite_2d.flip_h = direction > 0 # Agar right ja raha hai to flip karo (sprite ke hisaab se adjust kar lena)

	move_and_slide()

# Jab player kide se takraye, to use damage do
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("take_damage") and not is_dead:
		body.take_damage()

# Kide ki ek hit me maut
func take_damage():
	if is_dead: return
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite_2d.play("die") 
	if not ti.playing:
			ti.play()
	await animated_sprite_2d.animation_finished
	queue_free()

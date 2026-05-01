extends Area2D

# --- Settings ---
@export var kida_scene: PackedScene # Yahan Inspector se hum Kida scene daalenge
@export var total_kide_to_spawn = 15# Kitne kide nikalne hain? (Wave size)
@export var spawn_rate = 1.5# Har kida kitne seconds mein niklega?



var spawned_count = 0
var wave_started = false
@onready var spawn_point: Marker2D = $SpawnPoint 
@onready var spawn_point_2: Marker2D = $SpawnPoint2
@onready var spawn_point_3: Marker2D = $SpawnPoint3
@onready var spawn_timer: Timer = $CollisionShape2D/SpawnTimer


func _ready():
	# Timer ki setting script se hi kar dete hain
	spawn_timer.wait_time = spawn_rate

# Jab player is area me ghusega
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not wave_started:
		start_wave()

func start_wave():
	wave_started = true
	print("Kido ki Wave shuru ho gayi!")
	spawn_timer.start()

# Ye function har 0.2 seconds mein chalega
func _on_spawn_timer_timeout() -> void:
	if spawned_count < total_kide_to_spawn:
		create_kida()
	else:
		# Jab saare kide nikal jayein, to spawner ko band kar do
		spawn_timer.stop()
		print("Wave khatam!")
		queue_free() # Spawner ka kaam khatam, isko delete kar do

func create_kida():
	# Agar kida_scene set nahi hai to error se bachne ke liye check
	if kida_scene == null:
		return
		
	# Naya kida banao
	var naya_kida = kida_scene.instantiate()
	
	# Us kide ko apne scene mein jodo
	get_parent().add_child(naya_kida)
	
	# Kide ko wahan set karo jahan tumhara Marker2D (SpawnPoint) hai
	naya_kida.global_position = spawn_point.global_position
	
	spawned_count += 1

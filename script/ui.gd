extends Control

# आपके सीन ट्री के हिसाब से सही पाथ
@onready var button_2: Button = $Button2
@onready var button_3: Button = $VBoxContainer/Button3
@onready var timer: Timer = $Button2/Timer



# आपके गेम के मेन सीन का पाथ (इसे अपनी फाइल के नाम के हिसाब से चेक कर लें)
var main_game_scene = "res://game.tscn"

func _ready():
	# बटन्स के क्लिक इवेंट को जोड़ना
	button_2.pressed.connect(_on_play_pressed)
	button_3.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	# 0.01 सेकंड का इंतज़ार (जैसा आपने मांगा था)
	await get_tree().create_timer(0.01).timeout
	# गेम सीन लोड करना
	get_tree().change_scene_to_file(main_game_scene)

func _on_exit_pressed():
	# गेम पूरी तरह बंद करना
	get_tree().quit()

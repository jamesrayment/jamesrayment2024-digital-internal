extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Quits game
func _on_button_2_pressed():
	get_tree().quit()

# Sends player back to the first level
func _on_button_pressed():
	get_tree().change_scene_to_file.bind("res://level1.tscn").call_deferred()

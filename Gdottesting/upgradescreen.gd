extends Node2D

@onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	get_node("Label").text = str("money=", global.money)
	get_node("progbar").set_value(global.upgradelevel * 10)
	get_node("progbar2").set_value(global.upgradelevel2 * 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = str("money=", global.money)
	get_node("progbar").set_value(global.upgradelevel * 10)
	get_node("progbar2").set_value(global.upgradelevel2 * 10)

func _on_button_pressed():
	if global.money >= 50:
		global.upgradelevel += 1
		global.money -= 50
	else:
		pass

func _on_button_2_pressed():
	if global.money >= 50:
		global.upgradelevel2 += 1
		global.money -= 50
	else:
		pass


func _on_continue_pressed():
	if global.level == 1:
		get_tree().change_scene_to_file.bind("res://level2.tscn").call_deferred()

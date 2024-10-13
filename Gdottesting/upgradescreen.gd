extends Node2D

@onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	get_node("Label").text = str("money=", global.money)

	global.money = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = str("money=", global.money)

func _on_button_pressed():
	if global.money >= 50:
		global.upgradelevel += 1
		global.money -= 50
		get_node("Button").text = str("Speed level = ", global.upgradelevel)
	else:
		pass

func _on_button_2_pressed():
	if global.money >= 50:
		global.upgradelevel2 += 1
		global.money -= 50
		get_node("Button2").text = str("Ammo level = ", global.upgradelevel2)
	else:
		pass


func _on_continue_pressed():
	if global.level == 1:
		get_tree().change_scene_to_file.bind("res://level2.tscn").call_deferred()
	if global.level == 2:
		get_tree().change_scene_to_file.bind("res://level3.tscn").call_deferred()


func _on_button_3_pressed():
	if global.money >= 50:
		global.upgradelevel3 += 1
		global.money -= 50
		get_node("Button3").text = str("Health level = ", global.upgradelevel3)
	else:
		pass

extends Node2D

@onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	global.money = 60


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = str("money=", global.money)
	get_node("progbar").set_value(global.upgradelevel * 10)


func _on_button_pressed():
	if global.money >= 50:
		global.upgradelevel += 1
		global.money -= 50
	else:
		pass

extends Node3D

@onready var player = $Player
@onready var global = get_node("/root/Global")


var player_dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	global.level = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_dead == false:
		get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)
	else:
		return


func _on_player_player_death():
	player_dead = true
	get_tree().quit()

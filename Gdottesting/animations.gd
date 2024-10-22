extends Node3D

signal enemy_death_anim
signal enemy_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# When animation finishes, a signal is emitted for the enemy's death
func death_finish():
	emit_signal("enemy_death_anim")

# Signal for enemy attacking the playert
func enemy_attack():
	emit_signal("enemy_hit")

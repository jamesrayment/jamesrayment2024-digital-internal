extends Node

var money = 0

# Speed Level
var upgradelevel = 0

# Ammo Level
var upgradelevel2 = 0

# Health Level
var upgradelevel3 = 0

# Game Level
var level = 1

var save_path = "user://variable.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

# Save variables
func save():
	print(money)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(money)
	file.store_var(upgradelevel)
	file.store_var(upgradelevel2)
	file.store_var(upgradelevel3)

# load variables
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		money = file.get_var(money)
		upgradelevel = file.get_var(upgradelevel)
		upgradelevel2 = file.get_var(upgradelevel2)
		upgradelevel3 = file.get_var(upgradelevel3)
		
		print(money)
	else:
		print("no data found")

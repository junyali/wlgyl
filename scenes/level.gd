## This may be the worst code I've ever written
extends Node2D

@onready var label = $Label
@onready var popularity: int = randi_range(8,14)
@onready var price: int = randi_range(8,14)
@onready var whimsy: int = randi_range(8,14)

# super_heal, valuable, hard, spiky, tasty, lemon, pepper
@onready var popularities = {"super_healing": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
							
@onready var prices = {"super_heaingl": -popularities["super_healing"] + randi_range(-1, 1),
							 "valuable": -popularities["valuable"] + randi_range(-1, 1),
							 "hard": -popularities["hard"] + randi_range(-1, 1),
							 "spiky": -popularities["spiky"] + randi_range(-1, 1),
							 "tasty": -popularities["tasty"] + randi_range(-1, 1),
							 "lemon": -popularities["lemon"] + randi_range(-1, 1),
							 "pepper": -popularities["pepper"] + randi_range(-1, 1)}
							
@onready var whimsies = {"super_healing": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.update.connect(_update_scores)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Popularity: " + str(popularity) + "\nPrice: " + str(price) + "\n Whimsy: " + str(whimsy)
	if popularity == 0 or price == 0 or whimsy == 0:
		label.text = "You lose!"
	var tick = randi_range(0, 1000)
	if tick == 1000:
		print("ping")
		popularities = {"super_healing": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
							
		prices = {"super_healing": -popularities["super_healing"] + randi_range(-1, 1),
							 "valuable": -popularities["valuable"] + randi_range(-1, 1),
							 "hard": -popularities["hard"] + randi_range(-1, 1),
							 "spiky": -popularities["spiky"] + randi_range(-1, 1),
							 "tasty": -popularities["tasty"] + randi_range(-1, 1),
							 "lemon": -popularities["lemon"] + randi_range(-1, 1),
							 "pepper": -popularities["pepper"] + randi_range(-1, 1)}
							
		whimsies = {"super_healing": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
	elif tick < 10:
		popularity -= 1
		price -= 1
		whimsy -= 1

# Takes in a lemon, updates score
func _update_scores(lemon) -> void:
	# Popularity
	popularity += popularities[lemon]
	# Price
	price += prices[lemon]
	# Whimsy
	whimsy += whimsies[lemon]

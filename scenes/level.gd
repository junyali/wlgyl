## This may be the worst code I've ever written
extends Node2D

@onready var popularity: int = randi_range(8,14)
@onready var price: int = randi_range(8,14)
@onready var whimsy: int = randi_range(8,14)


# super_heal, valuable, hard, spiky, tasty, lemon, pepper
@onready var popularities = {"super_heal": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
							
@onready var prices = {"super_heal": popularities["super_heal"] + randi_range(-1, 1),
							 "valuable": popularities["valuable"] + randi_range(-1, 1),
							 "hard": popularities["hard"] + randi_range(-1, 1),
							 "spiky": popularities["spiky"] + randi_range(-1, 1),
							 "tasty": popularities["tasty"] + randi_range(-1, 1),
							 "lemon": popularities["lemon"] + randi_range(-1, 1),
							 "pepper": popularities["pepper"] + randi_range(-1, 1)}
							
@onready var whimsies = {"super_heal": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if randi_range(0, 10000) == 10000:
		popularities = {"super_heal": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}
							
		prices = {"super_heal": popularities["super_heal"] + randi_range(-1, 1),
							 "valuable": popularities["valuable"] + randi_range(-1, 1),
							 "hard": popularities["hard"] + randi_range(-1, 1),
							 "spiky": popularities["spiky"] + randi_range(-1, 1),
							 "tasty": popularities["tasty"] + randi_range(-1, 1),
							 "lemon": popularities["lemon"] + randi_range(-1, 1),
							 "pepper": popularities["pepper"] + randi_range(-1, 1)}
							
		whimsies = {"super_heal": randi_range(-3,3),
							 "valuable": randi_range(-3,3),
							 "hard": randi_range(-3, 3),
							 "spiky": randi_range(-3,3),
							 "tasty": randi_range(-3,3),
							 "lemon": randi_range(-3,3),
							 "pepper": randi_range(-3,3)}

# Takes in a lemon, updates score
func update_scores(lemon) -> void:
	# Popularity
	popularity += popularities[lemon.type]
	# Price
	price += prices[lemon.type]
	# Whimsy
	whimsy += whimsies[lemon.type]

	
	

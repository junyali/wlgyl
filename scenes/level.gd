extends Node2D

@onready var popularity: int = 10
@onready var price: int = 10
@onready var whimsy: int = 10

@onready var popularities = {}
@onready var prices = {}
@onready var whimsies = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Takes in a lemon, updates score
func update_scores(lemon) -> void:
	# Popularity
	popularity += popularities[lemon.type]
	# Price
	price += prices[lemon.type]
	# Whimsy
	whimsy += whimsies[lemon.type]

	
	

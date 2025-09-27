extends StaticBody2D

@export var harvest_cue: bool = true
@export var cue_range: float = 32.0
@export var cue_colour: Color = Color(1.5, 1.5, 1,5)

@onready var sprite: Sprite2D = $Sprite
@onready var cue_sprite: Sprite2D = $CueSprite
@onready var tool_hint_sprite: Sprite2D = $ToolHintSprite
@onready var cue_area: CollisionShape2D = $CueArea/Detect
@onready var tick_timer: Timer = $Tick

var growth_stage_time: float = 1.0
var seed: String = ""
var phase: int = 0
var is_planted: bool = false
var is_harvested: bool = false
var harvest_amount: int = 0

func _ready() -> void:
	add_to_group("crop")
	if cue_area.shape is CircleShape2D:
		cue_area.shape.radius = cue_range
		
	tick_timer.wait_time = growth_stage_time
	setup_cue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func plant(planted_seed: String) -> bool:
	if is_planted: return false
	seed = planted_seed
	is_planted = true
	change_phase()
	update_appearance()
	tick_timer.start()
	return true
	
func harvest() -> int:
	if is_planted and phase == 7:
		phase = 5
		harvest_amount += 1
		if harvest_amount >= 3:
			tick_timer.stop()
			seed = ""
			phase = 0
			is_planted = false
			harvest_amount = 0
		else:
			tick_timer.start()
		update_appearance()
		return randi_range(LemonDict.TheBigBookOfLemons[seed]["harvest_rand_min"], LemonDict.TheBigBookOfLemons[seed]["harvest_rand_max"])
	else:
		return 0
	
func change_phase() -> void:
	if 0 <= phase and phase < 5:
		phase += 1
	else:
		if phase == 7:
			return
		else:
			phase += 1
			
func update_appearance() -> void:
	match phase:
		0:
			sprite.texture.region = Rect2(96, 32, 32, 32)
			sprite.offset = Vector2(0, -16)
		1:
			sprite.texture.region = Rect2(0, 0, 32, 32)
			sprite.offset = Vector2(0, -16)
		2:
			sprite.texture.region = Rect2(32, 0, 32, 32)
			sprite.offset = Vector2(0, -16)
		3:
			sprite.texture.region = Rect2(64, 0, 32, 32)
			sprite.offset = Vector2(0, -16)
		4:
			sprite.texture.region = Rect2(96, 0, 32, 32)
			sprite.offset = Vector2(0, -16)
		5:
			sprite.texture.region = Rect2(0, 32, 32, 32)
			sprite.offset = Vector2(0, -16)
		6:
			sprite.texture.region = Rect2(32, 32, 32, 32)
			sprite.offset = Vector2(0, -16)
		7:
			sprite.texture.region = Rect2(64, 32, 32, 32)
			sprite.offset = Vector2(0, -16)
	
func setup_cue() -> void:
	if harvest_cue:
		cue_sprite.modulate.a = 0
		tool_hint_sprite.modulate.a = 0

		var start_pos: Vector2 = tool_hint_sprite.position
		var hint_tween: Tween  = create_tween().set_loops()
		hint_tween.tween_property(tool_hint_sprite, "position:y", start_pos.y - 1.0, 0.5)
		hint_tween.tween_property(tool_hint_sprite, "position:y", start_pos.y, 0.5)
		
func fade_out(time: float = 1.0) -> void:
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(cue_sprite, "modulate:a", 0.0, time * 0.3)
	tween.tween_property(tool_hint_sprite, "modulate:a", 0.0, time * 0.3)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 0), time)
	await tween.finished
	queue_free()

func show_cue() -> void:
	if harvest_cue:
		tween_sprite(cue_colour)
		
		var tween: Tween = create_tween()
		tween.tween_property(cue_sprite, "modulate:a", 1.0, 0.3)
		tween.parallel().tween_property(tool_hint_sprite, "modulate:a", 1.0, 0.3)

func hide_cue() -> void:
	tween_sprite(Color(1, 1, 1))
	var tween: Tween = create_tween()
	tween.tween_property(cue_sprite, "modulate:a", 0.0, 0.3)
	tween.parallel().tween_property(tool_hint_sprite, "modulate:a", 0.0, 0.3)

func tween_sprite(colour: Color, duration: float = 1.0) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate", colour, duration)

func _on_cue_area_body_entered(body: Node2D) -> void:
	var player: bool = body.is_in_group("player")
	if player:
		show_cue()

func _on_cue_area_body_exited(body: Node2D) -> void:
	var player: bool = body.is_in_group("player")
	if player:
		hide_cue()

func _on_tick_timeout() -> void:
	if is_planted:
		change_phase()
		update_appearance()
		tick_timer.start()
	else:
		tick_timer.stop()
		return
		

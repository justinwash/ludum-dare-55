extends CharacterBody2D

# Player movement speed
@export var speed = 60
@export var hp = 100
@export var hp_max = 100
@export var mp = 100
@export var mp_max = 100
@export var mp_per_second = 1
@export var friendly = false

@onready var abilities = $Abilities

var current_target = null
var target_in_range = false

var t = 0

# Target position for movement
var target_position: Vector2

func _ready():
  
  var player = get_tree().root.get_node("Game/Player")
  if friendly:
    $FriendlyIndicator.visible = true
    $EnemyIndicator.visible = false
    add_to_group("friendly_actor")
    if name.contains("Skeleton"):
      add_to_group("friendly_skeleton")
    if name.contains("Bowman"):
      add_to_group("friendly_bowman")
    if name.contains("Ghoul"):
      add_to_group("friendly_ghoul")
  else:
    $FriendlyIndicator.visible = false
    $EnemyIndicator.visible = true

func _physics_process(delta: float) -> void:
  t += 1
  if t % 60 == 0:
    mp += mp_per_second if mp < mp_max else 0
  
  if friendly:
    if get_tree().root.get_node("Game").selected_units.has(self):
      $SelectIndicator.visible = true
    else:
      $SelectIndicator.visible = false
  else:
    $SelectIndicator.visible = false
    
  if current_target:
    abilities.attack(current_target)
    
func _on_area_2d_input_event(viewport, event, shape_idx):
  if friendly:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
      get_tree().root.get_node("Game").selected_units = [self]


func _on_target_area_body_entered(body):
  if !body.friendly && !current_target:
    current_target = body
    
func _on_target_area_body_exited(body):
  if body == current_target:
    current_target = null
    
func _on_attack_area_body_entered(body):
  if body == current_target:
    target_in_range = true

func _on_attack_area_body_exited(body):
  if body == current_target:
    target_in_range = false

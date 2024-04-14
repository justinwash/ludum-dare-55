extends Button

@onready var game = get_tree().root.get_node("Game")
@onready var player = get_tree().root.get_node("Game/Player")

@export var ability_name = "summon"
@export var cost = 20
@export var required_unit_name = "Player"
@export var hotkey = "q"

func _physics_process(_delta):
  if required_unit_name == "Player":
    if player.mp >= cost:
      disabled = false
    else:
      disabled = true
  elif game.selected_units.any(has_type_and_mp):
    disabled = false
  else:
    disabled = true
      
  if Input.is_action_just_pressed(hotkey) && !disabled:
    _on_pressed()

func _on_pressed():
  game.active_ability = self
  print('active ability set: ', game.active_ability)
  
func has_type_and_mp(unit):
  return unit.name.contains(required_unit_name) && unit.mp >= cost
      

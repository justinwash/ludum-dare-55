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
      
  if Input.is_action_just_pressed(hotkey):
    _on_pressed()


func _on_pressed():
  game.active_ability = ability_name
      

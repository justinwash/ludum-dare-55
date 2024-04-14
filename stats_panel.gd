extends PanelContainer

@onready var player = get_tree().root.get_node("Game/Player")

@onready var healthbar = $VBoxContainer/Healthbar
@onready var manabar = $VBoxContainer/Manabar

func _physics_process(_delta):
  healthbar.value = player.hp
  manabar.value = player.mp

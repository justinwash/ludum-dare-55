extends VBoxContainer

@onready var label = $Label
@onready var healthbar = $Healthbar
@onready var manabar = $Manabar

var unit = null

func _physics_process(_delta):
  if unit:
    healthbar.value = unit.hp 
    healthbar.max_value = unit.hp_max
    manabar.value = unit.mp
    manabar.max_value = unit.mp_max

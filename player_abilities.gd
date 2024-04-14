extends Node

@onready var parent = get_node("../")

func summon(target, cost):
  print('summon called on ', parent, ' targeting ', target)
  parent.mp -= cost
  
func banish(target, cost):
  print('banish called on ', parent, ' targeting ', target)
  parent.mp -= cost
  
func blight(target, cost):
  print('blight called on ', parent, ' targeting ', target)
  parent.mp -= cost

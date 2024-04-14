extends Node

@onready var parent = get_node("../")

func deathwave(target, cost):
  print('deathwave called on ', parent, ' targeting ', target)
  parent.mp -= cost

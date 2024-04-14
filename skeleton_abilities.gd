extends Node

@onready var parent = get_node("../")

func attack(target):
  print('attacking target ', target)

func charge(target, cost):
  print('charge called on ', parent, ' targeting ', target)
  parent.mp -= cost

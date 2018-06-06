tool
extends Node

static func push_next(array, val, index):
	var n_array = []
	for i in range(0, index):
		n_array.append(array[i])
	n_array.append(val)
	for i in range(index,array.size()):
		n_array.append(array[i])
	return n_array

static func pop_next(array, index):
	var n_array = []
	for i in range(0, index):
		n_array.append(array[i])
	for i in range(index+1,array.size()):
		n_array.append(array[i])
	return n_array

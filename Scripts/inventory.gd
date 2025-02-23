extends Interactive
class_name Inventory

func _ready():
	remove_non_items()
	collect_duplicates()
	print("Printing Bag")
	for i in range($Bag.get_child_count()):
		var child = $Bag.get_child(i)
		print(child, "item_name:%s quantity:%s" % [child.item_name, child.quantity])
	print("Printing Junk")
	for i in range($Junk.get_child_count()):
		var child = $Junk.get_child(i)
		print(child)
	clear_junk()

func interact():
	transfer_to_other_inventory(other)

func transfer_to_other_inventory(o : Inventory):
	while $Bag.get_child_count() > 0:
		var item = $Bag.get_child(0)
		$Bag.remove_child(item)
		o.get_node("Bag").add_child(item)
		
func collect_duplicates():
	var i = 0
	while i < $Bag.get_child_count() - 1:
		var child = $Bag.get_child(i)
		var j = i + 1
		var kept_quantity = child.quantity
		while j < $Bag.get_child_count():
			var other_child = $Bag.get_child(j)
			if child.item_name == other_child.item_name:
				#other_child.quantity += child.quantity
				kept_quantity += other_child.quantity
				$Bag.remove_child(other_child)
				$Junk.add_child(other_child)
			else:
				j += 1
		child.quantity = kept_quantity
		i += 1

func remove_non_items():
	var i = 0
	while i < $Bag.get_child_count():
		var child = $Bag.get_child(i)
		if not child is Item:
			print("found non item")
			$Bag.remove_child(child)
			$Junk.add_child(child)
		else:
			print("found item")
			i += 1
			
func clear_junk():
	for i in range($Junk.get_child_count()):
		$Junk.get_child(i).queue_free()
		
# for inventories that are children of characters
func move_everything_to_bag():
	while get_child_count() > 2:
		var child = get_child(2)
		remove_child(child)
		$Bag.add_child(child)

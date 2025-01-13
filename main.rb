require_relative 'lib/BST'

require_relative 'lib/node'

tree = BST.new



tree.build_tree((Array.new(15) { rand(1..100) }))


tree.pretty_print


p tree.balanced?

tree.level_order

tree.preorder

tree.inorder

tree.postorder

arr = Array.new(50) {rand(101..200)}

arr.each {|n| tree.insert(n)}
puts ""
tree.pretty_print

puts tree.balanced?

tree.rebalance

tree.pretty_print

p tree.balanced?


tree.level_order

tree.preorder

tree.inorder

tree.postorder

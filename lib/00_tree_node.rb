module Searchable
  def dfs(target_value)
    #depth first search traverses the structure of a tree vertically, reaching
    #the bottom of a tree and then searching horizontally.

    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    #breadth first search instead searches the children of a node horizontally. The
    # children of a node are arranged in an array and searched one by one.
    nodes = [self]
    until nodes.empty?
      node = nodes.shift

      return node if node.value == target_value
      nodes.concat(node.children)
    end

    nil
  end

  def max_depth
    if children.empty?
      #if the node has no children, return 1 to represent a depth of 1
      # a root with no children has a depth of 1.
      1
    else
      #if children exist, create a new array containing the results of calling
      #max_depth rescursively on each child node. When we reach the base case, we are
      #left with 1. As we go back up the rescursive calls, 1 is added to the result
      #and the highest number is returned - the max depth.
      children.map(&:max_depth).max + 1
    end
  end
end

class PolyTreeNode
  include Searchable
  attr_accessor :value

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def parent=(parent_node)
      #nodes can only have one parent! So reassigning a parent
      #must remove the child node from the previous parent's children
      if @parent
        @parent.children.delete(self)
      end

      @parent = parent_node
      return if parent_node.nil?

      if parent_node.children.include?(self)
        return
      else
        parent_node.children.push(self)
      end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    #parent= method handles removing child_node from parent's children.
    if child_node && !self.children.include?(child_node)
      raise "That node is not a child of target parent node and can't be removed."
    end
    child_node.parent = nil
  end

end

include Java

import javax.swing.JTree
import javax.swing.tree.DefaultMutableTreeNode

require "./parser/Parser"

class TreeView
  attr_reader :jtree

  def initialize_tree(tree)
    root = create_tree(pr.info)
    build_tree(root, tree)
  end

  private

  def build_tree(root, obj)
    if obj.left
      child_node = create_node(obj.left.info, root)
      build_tree(child_node, obj.left)
    end

    if obj.right
      child_node = create_node(obj.right.info, root)
      build_tree(child_node, obj.right)
    end
  end

  def create_tree(root_name)
    root  = DefaultMutableTreeNode.new(root_name)
    @jtree = JTree.new(root)
    root
  end

  def create_node(child_node_content, parent_node)
    child_node = DefaultMutableTreeNode.new(child_node_content)
    parent_node.add(child_node)
    child_node
  end
end

TreeView.new

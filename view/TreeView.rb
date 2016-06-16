include Java

import javax.swing.JTree
import javax.swing.tree.DefaultMutableTreeNode
import javax.swing.tree.DefaultTreeModel

require "./parser/Parser"

class TreeView
  attr_accessor :jtree, :tree, :result

  def initialize
    @jtree = JTree.new
  end

  def start(expression)
    parser = Parser.new
    parser.parse(expression)
    @tree   = parser.tree
    @result = parser.result

    create_tree
  end

  def create_tree
    root_name   = @tree.info
    root_node   = DefaultMutableTreeNode.new(root_name)
    @tree_model = @jtree.get_model
    @tree_model.set_root root_node
    @jtree.set_shows_root_handles true

    build_tree(root_node, @tree)
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

  def create_node(child_node_content, parent_node)
    child_node = DefaultMutableTreeNode.new(child_node_content)
    parent_node.add(child_node)
    child_node
  end
end

TreeView.new

include Java

import javax.swing.JTree
import javax.swing.tree.DefaultMutableTreeNode
import javax.swing.tree.DefaultTreeModel

require "./parser/Parser"

class TreeView
  attr_accessor :jtree, :result, :history, :history_state

  def initialize
    @jtree = JTree.new

    @tree_model = @jtree.get_model
    @tree_model.set_root nil
  end

  def start(expression)
    parser = Parser.new
    parser.parse(expression)
    @_tree   = parser.tree
    @result = parser.result
    @history = parser.history
    @history_state = 0

    create_tree
  end

  def destroy
    @history = []
    @history_state = 0
    @tree_model.set_root nil
  end

  def tree
    @history[@history_state]
  end

  def inc
    @history_state += 1 if @history_state < @history.size - 1
    create_tree
  end

  def dec
    @history_state -= 1 if @history_state > 0
    create_tree
  end

  private

  def create_tree
    root_name   = expand_labels tree.info
    root_node   = DefaultMutableTreeNode.new(root_name)
    @tree_model.set_root root_node
    @jtree.set_shows_root_handles true

    build_tree(root_node, tree)
    (0..(@history.size - @history_state)).to_a.each { expand_all }
  end

  def build_tree(root, obj)
    if obj.left
      child_node = create_node(expand_labels(obj.left.info), root)
      build_tree(child_node, obj.left)
    end

    if obj.right
      child_node = create_node(expand_labels(obj.right.info), root)
      build_tree(child_node, obj.right)
    end
  end

  def create_node(child_node_content, parent_node)
    child_node = DefaultMutableTreeNode.new(child_node_content)
    parent_node.add(child_node)
    child_node
  end

  def expand_labels(label)
    case label
    when "q"
      return "sqrt"
    when "p"
      return "1/x"
    when "c"
      return "cos"
    when "s"
      return "sin"
    when "t"
      return "tan"
    else
      label
    end
  end

  def expand_all
    (0..@jtree.getRowCount).to_a.each do |index|
      @jtree.expand_row(index)
    end
  end
end

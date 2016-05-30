include Java

import javax.swing.JTree
import javax.swing.tree.DefaultMutableTreeNode

class Tree
  def create_tree(root_name)
    root = DefaultMutableTreeNode.new(root_name)
    @tree ||= JTree.new(root)
  end

  def create_node(child_node_content, parent_node)
    child_node = DefaultMutableTreeNode.new(child_node_content)
    parent_node.add(child_node)
    parent_node
  end
end

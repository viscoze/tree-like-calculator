class TreeState

  OP_FUNCTION = {
    "+" => lambda { |x, y| x + y },
    "-" => lambda { |x, y| x - y },
    "*" => lambda { |x, y| x * y },
    "/" => lambda { |x, y| x / y },
    "%" => lambda { |x, y| x % y },
    "q" => lambda { |x| (Math.sqrt x) },
    "p" => lambda { |x| (1/x) },
    "c" => lambda { |x| (Math.cos x) },
    "s" => lambda { |x| (Math.sin x) },
    "t" => lambda { |x| (Math.tan x) }
  }

  def initialize
    @tree_state = []
  end

  def self.eval(node)
    val = if !node.leaf? and node.operator?(node.info)
      unless node.left.nil?
        OP_FUNCTION[node.info].call(eval(node.left).info.to_f, eval(node.right).info.to_f)
      else
        OP_FUNCTION[node.info].call(eval(node.right).info.to_f)
      end
    else
      node
    end
  end

  def self.eval_(node)
    if !node.leaf? and node.operator?(node.info)
      if node.left
        if node.left.leaf? && node.right.leaf?
          TreeNode.new OP_FUNCTION[node.info].call(node.left.info.to_f, node.right.info.to_f)
        elsif (!node.left.leaf? && !node.right.leaf?) || (!node.right.leaf?)
          n = TreeNode.new(node.info)
          n.left = node.left
          n.right = eval_(node.right)
          n
        elsif !node.left.leaf?
          n = TreeNode.new(node.info)
          n.left = eval_(node.left)
          n.right = node.right
          n
        end
      else
        if node.right.leaf?
          TreeNode.new OP_FUNCTION[node.info].call(node.right.info.to_f)
        else
          node
        end
      end
    else
      node
    end
  end

  def self.eval_root(node)
    _n = [node]

    while !_n.last.leaf?
      _n << eval_(_n.last)
    end

    puts _n

    [_n, _n.last.info.to_f]
  end
end

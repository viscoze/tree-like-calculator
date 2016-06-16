require './parser/TreeNode'

class Parser
  attr_accessor :tree

  def parse(expression)
    @tree = infix_exp_to_tree(expression)
  end

  def result
    @tree.eval
  end

  private

  OP_PRIORITY = {
    "+" => 0,
    "-" => 0,
    "*" => 1,
    "/" => 1,
    "%" => 1
  }

  def tokenize(exp)
    exp
      .gsub('(', ' ( ')
      .gsub(')', ' ) ')
      .gsub('+', ' + ')
      .gsub('-', ' - ')
      .gsub('*', ' * ')
      .gsub('/', ' / ')
      .gsub('%', ' % ')
      .split(' ')
  end

  def operator?(token)
    OP_PRIORITY.has_key?(token)
  end

  def pop_connect_push(op_stack, node_stack)
    temp = op_stack.pop
    temp.right = node_stack.pop
    temp.left = node_stack.pop
    node_stack.push(temp)
  end

  def infix_exp_to_tree(exp)
    tokens = tokenize(exp)
    op_stack, node_stack = [], []

    tokens.each do |token|
      if operator?(token)
        until (op_stack.empty? or
               op_stack.last.info == "(" or
               OP_PRIORITY[op_stack.last.info] < OP_PRIORITY[token])
          pop_connect_push(op_stack, node_stack)
        end

        op_stack.push(TreeNode.new(token))
      elsif token == "("
        op_stack.push(TreeNode.new(token))
      elsif token == ")"
        while op_stack.last.info != "("
          pop_connect_push(op_stack, node_stack)
        end

        op_stack.pop
      else
        node_stack.push(TreeNode.new(token))
      end
    end

    until op_stack.empty?
      pop_connect_push(op_stack, node_stack)
    end

    node_stack.last
  end
end

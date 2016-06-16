class TreeNode
  attr_accessor :info, :left, :right

  OP_FUNCTION = {
    "+" => lambda {|x, y| x + y},
    "-" => lambda {|x, y| x - y},
    "*" => lambda {|x, y| x * y},
    "/" => lambda {|x, y| x / y},
    "%" => lambda {|x, y| x % y}
  }

  OP_PRIORITY = {
    "+" => 0,
    "-" => 0,
    "*" => 1,
    "/" => 1,
    "%" => 1
  }

  def initialize(info="")
    @info = info
  end

  def leaf?
    @left.nil? and @right.nil?
  end

  def operator?(token)
    OP_PRIORITY.has_key?(token)
  end

  def to_s
    if leaf?
      @info
    else
      "(" + [@info, @left.to_s, @right.to_s].join(" ") + ")"
    end
  end

  def eval
    if !leaf? and operator?(@info)
      OP_FUNCTION[@info].call(@left.eval, @right.eval)
    else
      @info.to_f
    end
  end
end

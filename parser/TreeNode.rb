class TreeNode
  attr_accessor :info, :left, :right

  OP_FUNCTION = {
    "+" => lambda { |x, y| x + y },
    "-" => lambda { |x, y| x - y },
    "*" => lambda { |x, y| x * y },
    "/" => lambda { |x, y| x / y },
    "%" => lambda { |x, y| x % y },
    "q" => lambda { |x| (x^0.5) },
    "p" => lambda { |x| (1/x) },
    "c" => lambda { |x| (Math.cos x) },
    "s" => lambda { |x| (Math.sin x) },
    "t" => lambda { |x| (Math.tan x) }
  }

  OP_PRIORITY = {
    "+" => 0,
    "-" => 0,
    "*" => 1,
    "/" => 1,
    "%" => 1,
    "q" => 2,
    "p" => 2,
    "c" => 2,
    "s" => 2
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
      unless @left.nil?
        OP_FUNCTION[@info].call(@left.eval, @right.eval)
      else
        OP_FUNCTION[@info].call(@right.eval)
      end
    else
      @info.to_f
    end
  end
end

class CalculatorCore
  def initialize
    @stack = []
    @number_stack = []
    # @tree_calc = TreeCalculator.new
  end

  def set_result_and_enter_label(result_label, enter_label)
    @result_label = result_label
    @enter_label  = enter_label
  end

  def render
    @enter_label.set_text(@stack.join(' '))
  end

  def add_token(token)

    if do_filter
      @stack.push(token)
      render
    end
  end

  def add_token(token)

    if is_a_number?(token)
      @number_stack << token
      token = @number_stack.join('')
    else
      @number_stack = []
    end

    if do_filter
      @stack.push(token)
      render
    end
  end

  def process_operation(operation)
  end

  private

  def is_a_number?(token)
    token == "0" || token.to_i != 0
  end

  def do_filter
    true
  end

  def evaluate
    # @tree_calc.evaluate @stack.join('')
  end
end

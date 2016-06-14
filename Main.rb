require './view/UserInterface'
require './controller/CalculatorCore'

class Main
  def main
    calc = CalculatorCore.new
    UserInterface.new calc
  end
end

Main.new.main

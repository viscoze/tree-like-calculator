include Java

import java.awt.BorderLayout
import java.awt.GridLayout
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JButton
import javax.swing.JLabel
import javax.swing.JTextField
import javax.swing.JScrollPane

require './view/TreeView'

class UserInterface
  attr_accessor :result_label, :enter_label

  def initialize(calculator)
    @calc  = calculator
    @frame = JFrame.new
    @tree  = TreeView.new

    initialize_user_interface
    initialize_frame_settings
  end

  def initialize_frame_settings
    @frame.set_title "Tree Calculator by Vlad"
    @frame.set_size 450,300
    @frame.set_location_relative_to nil
    @frame.set_default_close_operation JFrame::EXIT_ON_CLOSE
    @frame.set_resizable false
    @frame.set_visible true
  end

  def initialize_user_interface
    @result_label   = JLabel.new "RESULT"
    @enter_label    = JLabel.new

    main_panel      = JPanel.new GridLayout.new(1,2)
    cacl_side_panel = JPanel.new GridLayout.new(2,1)
    tree_side_panel = JPanel.new BorderLayout.new(2,1)

    calc_panel      = JPanel.new
    engin_panel     = JPanel.new
    number_panel    = initialize_input_panel

    tree_panel      = JScrollPane.new(@tree.create_tree)

    tree_side_panel.add(@result_label, BorderLayout::NORTH)
    tree_side_panel.add(tree_panel,   BorderLayout::CENTER)

    calc_panel.add(number_panel, BorderLayout::WEST)
    calc_panel.add(engin_panel,  BorderLayout::EAST)

    cacl_side_panel.add(@enter_label)
    cacl_side_panel.add(calc_panel)

    main_panel.add tree_side_panel
    main_panel.add cacl_side_panel

    @calc.set_result_and_enter_label(@result_label, @enter_label)
    @frame.add(main_panel)
  end

  def initialize_input_panel
    main_panel      = JPanel.new GridLayout.new(6,5)

    "<>C= ".split('').each do |symbol|
      button = JButton.new "#{symbol}"
      button.add_action_listener { @calc.process_operation(button.getLabel) }
      main_panel.add(button)
    end

    "789()456+*123-/.0 SP".split('').each do |number_label|
      button = JButton.new "#{number_label}"
      button.add_action_listener { @calc.add_token(button.getLabel) }
      main_panel.add(button)
    end

    main_panel
  end
end

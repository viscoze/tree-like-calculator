include Java

import java.awt.BorderLayout
import java.awt.GridLayout
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JButton
import javax.swing.JTextField

class UserInterface
  def initialize
    @frame = JFrame.new

    initialize_user_interface
    initialize_frame_settings
  end

  def initialize_frame_settings
    @frame.set_title "Tree Calculator by Vlad"
    @frame.set_size 680,480
    @frame.set_location_relative_to nil
    @frame.set_default_close_operation JFrame::EXIT_ON_CLOSE
    @frame.set_resizable false
    @frame.set_visible true
  end

  def initialize_user_interface
    main_panel = JPanel.new BorderLayout.new 2,1
    cacl_side_panel = JPanel.new
    tree_side_panel = JPanel.new

    enter_field  = JTextField.new 30
    calc_panel   = JPanel.new
    button_panel = JPanel.new
    engin_panel  = JPanel.new

    number_panel = initialize_input_panel
    main_panel.add(number_panel)

    # calc_panel.add button_panel, BorderLayout::CENTER
    # calc_panel.add engin_panel,  BorderLayout::EAST
    #
    # cacl_side_panel.add enter_field, BorderLayout::NORTH
    # cacl_side_panel.add calc_panel,  BorderLayout::CENTER
    #
    # main_panel.add tree_side_panel,  BorderLayout::WEST
    # main_panel.add cacl_side_panel,  BorderLayout::CENTER

    @frame.add(main_panel)
  end

  def initialize_input_panel
    main_panel      = JPanel.new BorderLayout.new
    number_panel    = JPanel.new GridLayout.new(4,3)
    control_panel   = JPanel.new GridLayout.new(1,5)
    operation_panel = JPanel.new GridLayout.new(3,2)

    "789456123 0.".split('').each do |number_label|
      button = JButton.new "#{number_label}"
      button.add_action_listener { }
      number_panel.add(button)
    end

    "<>C()".split('').each do |symbol|
      button = JButton.new "#{symbol}"
      button.add_action_listener { }
      control_panel.add(button)
    end

    "+*-/%=".split('').each do |symbol|
      button = JButton.new "#{symbol}"
      button.add_action_listener { }
      operation_panel.add(button)
    end

    main_panel.add(control_panel,   BorderLayout::NORTH)
    main_panel.add(operation_panel, BorderLayout::EAST)
    main_panel.add(number_panel,    BorderLayout::CENTER)

    main_panel
  end
end

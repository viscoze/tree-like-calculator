include Java

import java.awt.BorderLayout
import java.awt.GridLayout
import java.awt.Dimension
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JButton
import javax.swing.JLabel
import javax.swing.JTextField
import javax.swing.JScrollPane

require './view/TreeView'

class UserInterface
  attr_accessor :result_label, :enter_label

  def initialize
    @frame = JFrame.new
    @tree  = TreeView.new

    @input = []

    initialize_user_interface
    initialize_frame_settings
  end

  private

  def initialize_frame_settings
    @frame.set_title "Tree Calculator by Vlad"
    @frame.set_location_relative_to nil
    @frame.set_size 600,400
    @frame.set_default_close_operation JFrame::EXIT_ON_CLOSE
    @frame.set_resizable false
    @frame.set_visible true
  end

  def initialize_user_interface
    main_panel      = JPanel.new(BorderLayout.new)

    jtree_panel     = JPanel.new
    text_panel      = JPanel.new
    button_panel    = get_button_panel
    operation_panel = get_operation_panel

    jtree_scroll_pane = JScrollPane.new(@tree.jtree)
    jtree_scroll_pane.setPreferredSize(Dimension.new 120,250)
    jtree_panel.add(jtree_scroll_pane)

    @result_field = JTextField.new 10
    @input_field  = JTextField.new 40

    @result_field.set_editable(false)
    @input_field.set_editable(false)

    text_panel.add(@result_field)
    text_panel.add(@input_field)

    main_panel.add(button_panel, BorderLayout::CENTER)
    main_panel.add(operation_panel, BorderLayout::LINE_END)

    main_panel.add(text_panel,  BorderLayout::PAGE_START)
    main_panel.add(jtree_panel, BorderLayout::LINE_START)

    @frame.add(main_panel)
  end

  def get_operation_panel
    main_panel = JPanel.new(GridLayout.new 4,2)
    get_buttons("+-*/()%C",main_panel)
    main_panel
  end

  def get_button_panel
    main_panel = JPanel.new(GridLayout.new 4,3)
    get_buttons("789456123.0=",main_panel)
    main_panel
  end

  def get_complex_operation_panel
    "sqrt ln log fact 1/x".split(" ").each do |label|
    end
  end

  def push_input(token)
    @input.push(token)
    @input_field.set_text(@input.join(""))
  end

  def pop_input
    @input.pop
    @input_field.set_text(@input.join(""))
  end

  def show_tree
    @tree.start(@input.join(""))
    @result_field.set_text(@tree.result.to_s)
  end

  def get_buttons(button_string, panel)
    button_string.split('').each do |label|
      button = JButton.new "#{label}"
      set_action_to_button(button, label)
      panel.add(button)
    end
  end

  def set_action_to_button(button, label)
    case label
    when "="
      button.add_action_listener { show_tree }
    when "C"
      button.add_action_listener { pop_input }
    else
      button.add_action_listener { push_input(button.get_label) }
    end
  end
end

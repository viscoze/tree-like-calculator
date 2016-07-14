include Java

import java.awt.BorderLayout
import java.awt.GridLayout
import java.awt.Dimension
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JButton
import javax.swing.JLabel
import javax.swing.JTextField
import javax.swing.JTabbedPane
import javax.swing.JScrollPane

require './view/TreeView'
require './view/ButtonSetter'

class UserInterface
  include ButtonSetter
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
    @frame.set_size 900,400
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
    complex_operation_panel = get_complex_operation_panel

    jtree_scroll_pane = JScrollPane.new(@tree.jtree)
    jtree_scroll_pane.setPreferredSize(Dimension.new 150,300)
    jtree_panel.add(jtree_scroll_pane)

    @result_field = JTextField.new 15
    @input_field  = JTextField.new 45
    @state_field  = JTextField.new 45

    @result_field.set_editable(false)
    @input_field.set_editable(false)
    @state_field.set_editable(false)

    text_panel.add(@result_field)
    text_panel.add(@input_field)

    tab_pane = JTabbedPane.new

    tab_pane.add_tab("Bsc",   operation_panel)
    tab_pane.add_tab("Cmplx", complex_operation_panel)

    main_panel.add(tab_pane, BorderLayout::LINE_END)

    main_panel.add(button_panel, BorderLayout::CENTER)
    main_panel.add(text_panel,   BorderLayout::PAGE_START)
    main_panel.add(jtree_panel,  BorderLayout::LINE_START)
    main_panel.add(@state_field, BorderLayout::PAGE_END)

    @frame.add(main_panel)
  end

  def push_input(token)
    @input.push(token)
    input = expand_result_text(@input).join("")
    @input_field.set_text(input)
  end

  def pop_input
    @input.pop
    input = expand_result_text(@input).join("")
    @input_field.set_text(input)
  end

  def remove_input
    @input = []
    @input_field.set_text("")
    @result_field.set_text("")
    @state_field.set_text("")
    @tree.destroy
  end

  def show_tree
    @tree.start(@input.join(""))
    @result_field.set_text(@tree.result.to_s)
  end

  def state_result
    @state_field.set_text @tree.tree.to_s
  end

  def expand_result_text(text_list)
    text_list.map do |label|
      case label
      when "q"
        "sqrt"
      when "p"
        "1/x"
      when "c"
        "cos"
      when "s"
        "sin"
      when "t"
        "tan"
      else
        label
      end
    end
  end
end

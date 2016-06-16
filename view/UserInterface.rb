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
    complex_operation_panel = get_complex_operation_panel

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
    # main_panel.add(complex_operation_panel, BorderLayout::LINE_END)

    main_panel.add(text_panel,  BorderLayout::PAGE_START)
    main_panel.add(jtree_panel, BorderLayout::LINE_START)

    @frame.add(main_panel)
  end

  def push_input(token)
    @input.push(token)
    @input_field.set_text(@input.join(""))
  end

  def pop_input
    @input.pop
    @input_field.set_text(@input.join(""))
  end

  def remove_input
    @input = []
    @input_field.set_text("")
  end

  def show_tree
    @tree.start(@input.join(""))
    @result_field.set_text(@tree.result.to_s)
  end
end

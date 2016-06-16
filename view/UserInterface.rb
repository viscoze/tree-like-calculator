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

  def initialize()
    @frame = JFrame.new
    @tree  = TreeView.new

    initialize_user_interface
    initialize_frame_settings
  end

  def initialize_frame_settings
    @frame.set_title "Tree Calculator by Vlad"
    @frame.set_location_relative_to nil
    @frame.set_size 600,400
    @frame.set_default_close_operation JFrame::EXIT_ON_CLOSE
    @frame.set_resizable false
    @frame.set_visible true
  end

  def initialize_user_interface
    main_panel  = JPanel.new(BorderLayout.new)

    jtree_panel   = JPanel.new
    buttons_panel = JPanel.new
    text_panel    = JPanel.new

    jtree_scroll_pane = JScrollPane.new(@tree.jtree)
    jtree_scroll_pane.setPreferredSize(Dimension.new 120,250)
    jtree_panel.add(jtree_scroll_pane)

    @result = JTextField.new 10
    @input  = JTextField.new 40

    @result.set_editable(false)
    @input.set_editable(false)

    text_panel.add(@result)
    text_panel.add(@input)

    main_panel.add(text_panel,  BorderLayout::PAGE_START)
    main_panel.add(jtree_panel, BorderLayout::LINE_START)

    @frame.add(main_panel)
  end


  def initialize_input_panel
    main_panel      = JPanel.new GridLayout.new(6,5)

    "<>C= ".split('').each do |symbol|
      button = JButton.new "#{symbol}"
      # button.add_action_listener { @calc.process_operation(button.getLabel) }
      main_panel.add(button)
    end

    "789()456+*123-/.0 SP".split('').each do |number_label|
      button = JButton.new "#{number_label}"
      # button.add_action_listener { @calc.add_token(button.getLabel) }
      main_panel.add(button)
    end

    main_panel
  end
end

module ButtonSetter
  def get_operation_panel
    main_panel = JPanel.new(GridLayout.new 6,2)
    get_buttons("<>CD+-*/()",main_panel)
    main_panel
  end

  def get_button_panel
    main_panel = JPanel.new(GridLayout.new 4,3)
    get_buttons("789456123.0=",main_panel)
    main_panel
  end

  def get_complex_operation_panel
    main_panel = JPanel.new GridLayout.new 3,2

    "sqrt 1/x ln log fact".split(" ").each do |label|
      button = JButton.new "#{label}"
      set_action_to_complex_button(button, label)
      main_panel.add(button)
    end

    button = JButton.new "%"
    set_action_to_button(button, "%")
    main_panel.add(button)
    main_panel
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
    when "D"
      button.add_action_listener { remove_input }
    when "<"
    when ">"
    else
      button.add_action_listener { push_input(button.get_label) }
    end
  end

  def set_action_to_complex_button(button, label)
    case label
    when "sqrt"
    when "1/x"
    when "ln"
    when "log"
    when "fact"
    end
  end
end

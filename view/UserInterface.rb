include Java

import java.awt.BorderLayout
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JButton

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
    calculator_panel = JPanel.new
    tree_panel       = JPanel.new

    
  end
end

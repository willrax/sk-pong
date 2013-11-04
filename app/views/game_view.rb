class GameView < SKView
  # Add the game stats to the view
  def init
    super
    self.showsDrawCount = true
    self.showsFPS = true
    self.showsNodeCount = true
    self.multipleTouchEnabled = true
    self
  end
end

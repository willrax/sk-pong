class GameViewController < UIViewController
  # Override this method to assign an SKView class.
  def loadView
    self.view = GameView.alloc.init
  end

  # Makes sure that the current screen size is already set.
  # Also check for an existing scene. This will get called
  # multiple times throughout the app life cycle.
  def viewWillLayoutSubviews
    super

    unless self.view.scene
      tableScene = TableScene.alloc.initWithSize(self.view.bounds.size)
      self.view.presentScene tableScene
    end
  end
end

class TableScene < SKScene
  BALL = 0x1 << 0
  WALL = 0x1 << 1

  attr_accessor :contentCreated, :playerOneScore, :playerTwoScore

  def didMoveToView(view)
    super
    self.physicsWorld.gravity = CGVectorMake(0,0)
    self.physicsWorld.contactDelegate = self
    self.physicsBody = SKPhysicsBody.bodyWithEdgeLoopFromRect(self.frame)
    self.physicsBody.categoryBitMask = WALL
    self.physicsBody.contactTestBitMask = BALL

    unless contentCreated
      createSceneContents
      @contentCreated = true
    end
  end

  def didBeginContact(contact)
    playerTwoScore.text = "#{playerTwoScore.text.to_i + 1}" if contact.contactPoint.x < 3.0
    playerOneScore.text = "#{playerOneScore.text.to_i + 1}" if contact.contactPoint.x > 1010.57
  end

  def touchesMoved(touches, withEvent: event)
    touches.each do |touch|
      currentLocation = touch.locationInNode(self)
      selectedNode = self.nodesAtPoint(currentLocation).first

      if selectedNode && selectedNode.name == "paddle"
        selectedNode.setPosition(CGPointMake(selectedNode.position.x, currentLocation.y))
      end
    end
  end

  def createSceneContents
    self.backgroundColor = UIColor.whiteColor
    self.scaleMode = SKSceneScaleModeFill

    playerOne = newPaddle
    playerOne.position = CGPointMake(70, 90)
    playerTwo = newPaddle
    playerTwo.position = CGPointMake(960, 90)

    ball = newBall
    ball.position = CGPointMake(500, 90)

    @playerOneScore = newScoreLabel
    playerOneScore.position = CGPointMake(CGRectGetMidX(self.frame) - 60, 700)
    @playerTwoScore = newScoreLabel
    playerTwoScore.position = CGPointMake(CGRectGetMidX(self.frame) + 60, 700)

    self.addChild playerOne
    self.addChild playerTwo
    self.addChild playerOneScore
    self.addChild playerTwoScore
    self.addChild ball
    ball.physicsBody.applyImpulse CGVectorMake(20, 20)
  end

  def newScoreLabel
    board = SKLabelNode.alloc.initWithFontNamed("Helvetica Neue")
    board.fontColor = UIColor.blackColor
    board.fontSize = 55
    board.text = "0"
    board
  end

  def newBall
    ball = SKSpriteNode.alloc.initWithColor(UIColor.blackColor, size: CGSizeMake(32,32))
    ball.name = "ball"
    ball.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(ball.size)
    ball.physicsBody.restitution = 1.0
    ball.physicsBody.friction = 0.0
    ball.physicsBody.linearDamping = 0
    ball.physicsBody.angularDamping = 0
    ball.physicsBody.allowsRotation = false
    ball.physicsBody.categoryBitMask = BALL
    ball.physicsBody.contactTestBitMask = WALL
    ball
  end

  def newPaddle
    paddleBuffer = SKSpriteNode.alloc.initWithColor(UIColor.whiteColor, size: CGSizeMake(150,200))
    paddle = SKSpriteNode.alloc.initWithColor(UIColor.blackColor, size: CGSizeMake(34,120))
    paddle.position = CGPointMake(CGRectGetMidX(paddleBuffer.frame), CGRectGetMidY(paddleBuffer.frame))
    paddle.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(paddle.size)
    paddle.physicsBody.mass = 100000
    paddle.physicsBody.allowsRotation = false
    paddleBuffer.name = "paddle"
    paddleBuffer.addChild paddle
    paddleBuffer
  end
end

class BoardViewController < UIViewController
  SQUARE_SIZE = 80
  COLORS =  [
              UIColor.greenColor,
              UIColor.redColor,
              UIColor.whiteColor,
              UIColor.blueColor,
              UIColor.yellowColor,
              UIColor.orangeColor,
              UIColor.brownColor,
              UIColor.grayColor
            ]
  
  def viewDidLoad   
    self.init_views
    self.new_game 
    self.board_changed
  end
  
  def init_views
    view.backgroundColor = UIColor.blackColor
    
    # view for the board
    @board_view = UIView.alloc.initWithFrame([[0, 0], [SQUARE_SIZE * 4, SQUARE_SIZE * 4]])
    @board_view.center = view.center
    
    # views for the square
    @square_views = []
    for i in 0..4
      for j in 0..4
        square_view = UIView.alloc.initWithFrame([[j * (SQUARE_SIZE + 2), i * (SQUARE_SIZE + 2)], [SQUARE_SIZE - 4, SQUARE_SIZE - 4]])
        square_view.layer.cornerRadius = 5.0
        @square_views[4*i + j] = square_view
        @board_view.addSubview(square_view)
      end
    end
    
    # label for game information
    @label = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @label.textColor = UIColor.whiteColor
    @label.font = UIFont.systemFontOfSize(30)
    @label.backgroundColor = nil
    
    view.addSubview(@label)
    view.addSubview(@board_view)
  end
  
  def show_info(text)
    @label.text = text
    @label.sizeToFit
    @label.center = [160, 50]
  end
  
  def new_game
    # initalize the game
    @board = Board.new
    @current_player = 0
  end  
  
  def touchesEnded(touches, withEvent:event)
    # check if we're touching a square
    for i in 0..15
      if event.touchesForView(@square_views[i])
        @board.move(i)
        break
      end
    end
    # check if the game is over
    if @board.game_over?
      @board.reset
      show_info("Game finished")
    end
    board_changed
  end
  
  # update the square views
  def board_changed
    for i in 0..15
      if @board.grid[i].opened || @board.grid[i].active
        @square_views[i].backgroundColor = COLORS[@board.grid[i].color] 
      else
        @square_views[i].backgroundColor = UIColor.alloc.initWithRed(0.90, green: 0.85, blue: 0.90, alpha:1.0) 
      end
    end
  end
  
end
class Board
  
  # @grid:
  # +---+---+---+---+
  # | 0 | 1 | 2 | 3 |
  # +---+---+---+---+
  # | 4 | 5 | 6 | 7 |
  # +---+---+---+---+
  # | 8 | 9 |10 |11 |
  # +---+---+---+---+
  # |12 |13 |14 |15 |
  # +---+---+---+---+
  
  attr_accessor :grid
  
  def initialize
    @grid = []
    generate_answer.each do |colour|
      @grid << Cell.new(colour)
    end
  end
  
  # returns false if illegal move
  # and player id if it is legal
  def move(square)
    # opened 2 cells
    if opened_cells.count == 2 
      opened_two_cells
    end
    # opened closed cell
    if closed_cell?(square)
      @grid[square].open
    end
  end

  # if all active cells
  def game_over?
    last_one? ? true : false
  end

  private

  def closed_cell?(square)
    !@grid[square].opened && !@grid[square].active
  end

  def opened_two_cells
    if opened_cells.first.color == opened_cells.last.color
      return opened_same_cells
    end
    opened_different_cells
  end

  def opened_same_cells
    opened_cells.first.make_active
    opened_cells.last.make_active
  end

  def opened_different_cells
    opened_cells.first.close
    opened_cells.last.close
  end

  def last_one?
    inactive_cells.count - opened_cells.count == 0
  end

  def opened_cells
    grid.select{|cell| cell.opened == true}
  end

  def inactive_cells
    grid.select{ |cell| cell.active == false }
  end

  def generate_answer
    ((0..7).to_a * 2).shuffle
  end

end
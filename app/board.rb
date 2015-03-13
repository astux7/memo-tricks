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
  attr_reader :answer
  
  def initialize
    @answer, @grid = generate_answer, []
    @answer.each do |colour|
      @grid << Cell.new(colour)
    end
  end
  
  # returns false if illegal move
  # and player id if it is legal
  def move(square)
    if opened_cells.count == 2 
      if opened_cells.first.color == opened_cells.last.color
        opened_cells.first.make_active
        opened_cells.last.make_active
      else
        opened_cells.first.closed
        opened_cells.last.closed
      end
    end
    if @grid[square].opened == false && @grid[square].active==false
      @grid[square].opened = true
    end
  end

  # resets the grid
  def reset 
    @answer = generate_answer
    @grid = []
    @answer.each do |colour|
      @grid << Cell.new(colour)
    end
  end
  
  # if all active cells
  def game_over?
    last_one? ? true : false
  end

  private

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
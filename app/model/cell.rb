class Cell
  attr_reader :color
  attr_accessor :active, :opened
  def initialize(color, active=false, opened=false)
    @color = color
    @active = active
    @opened = opened
  end

  def make_active
    @active = true
    @opened = false
  end

  def close
    @opened = false
  end

  def open
    @opened = true
  end
end
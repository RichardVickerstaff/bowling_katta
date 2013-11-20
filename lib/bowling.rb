class Game
  def initialize
    @score = []
  end

  def roll pins
    @score << pins
  end

  def score
    @frames = []

    (0..19).reject(&:even?).each do |x|
      @frames << [@score[x-1], @score[x]]
    end
    @frames.map{|frame| {first: frame[0], second: frame[1], spare: (frame.inject(:+) == 10)} }
    @frames.each{|frame| frame[:first] + frame[:second]}
  end
end

class Game
  def initialize
    @score = []
  end

  def roll pins
    @score << pins
  end

  def score
    @frames = []

    (0..19).reject(&:odd?).each do |x|
      @frames << {first: @score[x], second: @score[x+1], spare: (@score[x] + @score [x+1] == 10)}
    end
    score = @frames.each_with_index.map do |frame, i|
      if frame[:spare]
        frame[:first] + frame[:second] + @frames[i+1][:first]
      else
        frame[:first] + frame[:second]
      end
    end
    score.inject(:+)
  end
end

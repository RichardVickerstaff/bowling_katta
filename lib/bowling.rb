class Game
  def initialize
    @score = []
  end

  def roll pins
    if pins == 10
      @score << pins
      @score << 0
    else
      @score << pins
    end
  end

  def score
    @frames = []

    (0..19).reject(&:odd?).each do |x|
      @frames << {first: @score[x], second: @score[x+1], spare: (@score[x] + @score [x+1] == 10 && @score[x] != 10), strike: (@score[x] == 10)}
    end
    score = @frames.each_with_index.map do |frame, i|
      if frame[:spare]
        frame[:first] + frame[:second] + @frames[i+1][:first]
      elsif frame[:strike]
        frame[:first] + @frames[i+1][:first] + @frames[i+1][:second]
      else
        frame[:first] + frame[:second]
      end
    end
    score.inject(:+)
  end
end

class Game
  def initialize
    @score = []
  end

  def roll pins
    if strike? pins
      if on_last_frame
        @score << pins
      else
        @score << pins
        @score << 0
      end
    else
      @score << pins
    end
  end

  def score
    @frames = []

    create_frames
    score = @frames.each_with_index.map do |frame, i|
      if frame[:spare]
        score_a_spare frame, i
      elsif frame[:strike]
        if last_frame i
          frame[:first] + frame[:second] + @score.last
        elsif penultimate_frame i
          frame[:first] + @frames[i+1][:first] + @frames[i+1][:second]
        elsif next_frame_is_a_strike? i
          frame[:first] + @frames[i+1][:first] + @frames[i+2][:first]
        else
          frame[:first] + @frames[i+1][:first] + @frames[i+1][:second]
        end
      else
        sum_score_for_frame frame
      end
    end
    score.inject(:+)
  end

  private
  def strike? pins
    pins == 10
  end

  def on_last_frame
    @score.length > 17
  end

  def last_frame frame_number
    frame_number == 9
  end

  def penultimate_frame frame_number
    frame_number == 8
  end

  def sum_score_for_frame frame
    frame[:first] + frame[:second]
  end

  def next_frame_is_a_strike?(current_frame)
    @frames[current_frame + 1][:strike]
  end

  def score_a_spare(frame, frame_number)
    frame[:first] + frame[:second] + @frames[frame_number + 1][:first]
  end

  def create_frames
    (0..19).reject(&:odd?).each do |x|
      @frames << {first: @score[x], second: @score[x+1], spare: (@score[x] + @score [x+1] == 10 && @score[x] != 10), strike: (@score[x] == 10)}
    end
  end
end

require 'bowling'

describe Game do
  describe "#score" do
    it "scores 0 for a guter game" do
      20.times { subject.roll 0 }
      expect(subject.score).to eq 0
    end

    it "scores 20 for all 1's" do
      20.times { subject.roll 1 }
      expect(subject.score).to eq 20
    end

    it "A spare in the first frame followed by three pins, followed by all misses scores 16" do
      2.times { subject.roll 5 }
      subject.roll 3
      17.times { subject.roll 0 }
      expect(subject.score).to eq 16
    end

    it "A strike in the first frame followed by three and then four pins, followed by all misses, scores 24." do
      subject.roll 10
      subject.roll 3
      subject.roll 4
      16.times { subject.roll 0 }
      expect(subject.score).to eq 24
    end

    it "A perfect game scores 300" do
      12.times { subject.roll 10 }
      expect(subject.score).to eq 300
    end
  end
end

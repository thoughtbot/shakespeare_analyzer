module SpeakerAggregator
  extend self

  def call(counts)
    sort(aggregate(counts))
  end

protected

  def speakers(counts)
    counts.map(&:name).uniq
  end

  def sort(counts)
    counts.sort { |a, b| b.line_count <=> a.line_count }
  end

  def aggregate(counts)
    speakers(counts).reduce([]) do |acc, speaker|
      line_counts = sum_lines_by_speaker(counts, speaker)
      acc << Speaker.new(speaker, line_counts)
    end
  end

  def sum_lines_by_speaker(list, speaker)
    lc = list.select { |obj| obj.name == speaker }.map(&:line_count)
    lc.reduce(:+)
  end
end

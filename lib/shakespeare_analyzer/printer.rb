module Printer
  extend self

  def call(counts)
    counts.each { |count| puts count.to_s }
  end
end

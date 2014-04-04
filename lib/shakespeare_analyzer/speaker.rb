class Speaker < Value.new(:name, :line_count)
  def to_s
    "#{@line_count} #{@name.capitalize}"
  end
end

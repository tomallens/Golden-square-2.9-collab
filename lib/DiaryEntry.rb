class DiaryEntry
  def initialize(entry)
    @entry = entry
  end

  def view
    return @entry
  end

  def word_counter
    @entry.count(" ") + 1
  end
  
end
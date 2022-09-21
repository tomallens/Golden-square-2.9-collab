class Diary
  def initialize
    @entry_list = []
    @todo_list = []
  end

  def add(instance)
    if instance.class == DiaryEntry
      @entry_list << instance
    elsif instance.class == Todo
      @todo_list << instance
    end
  end

  def view_all(instance)
    if instance == DiaryEntry
      return @entry_list.map { |entry| entry.view}
    elsif instance == Todo
      return @todo_list.map { |todo| todo.view}
    end
  end

  def contact_lister
    stringy_entry = @entry_list.map { |entry| entry.view}.join("")
    stringy_entry.scan(/07\d\d\d\d\d\d\d\d\d/).uniq
  end
    
  def find_readable(wpm, minutes)
    fail 'WPM & Reading time must be positive' if wpm == 0 || minutes == 0
    words = wpm * minutes
    readable_entries = @entry_list.filter { |entry| entry.word_counter <= words }
    string_entries = readable_entries.map{|entry|entry.view}
    if readable_entries.length == 0
      []
    else
      sorted_by_longest = string_entries.sort_by { |entry| entry.length }
    return [] << sorted_by_longest.last
    end
  end
end
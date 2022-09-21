require_relative '../lib/Diary'
require_relative '../lib/DiaryEntry'
require_relative '../lib/Todo'

RSpec.describe 'Integration' do
  it "Adds diary entry" do
    diary = Diary.new
    entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
    entry_2 = DiaryEntry.new("I met cat.")
    diary.add(entry_1)
    diary.add(entry_2)
    expect(diary.view_all(DiaryEntry)).to eq ["Today, I met Joe. His phone number is 07971300300", "I met cat."]
  end

  it "Adds todo" do
    diary = Diary.new
    todo_1 = Todo.new("Get that milk")
    todo_2 = Todo.new("Get that bread")
    diary.add(todo_1)
    diary.add(todo_2)
    expect(diary.view_all(Todo)).to eq ["Get that milk", "Get that bread"]
  end

  describe '#contacts' do
    context 'when given a single phone number in diary entries' do
      it 'returns contained phone numbers' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met cat.")
        diary.add(entry_1)
        diary.add(entry_2)
        expect(diary.contact_lister).to eq ["07971300300"]
      end
    end

    context 'when given other numbers' do
      it 'returns contained phone numbers' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met 0739 cats.")
        entry_3 = DiaryEntry.new("99999999999")
        entry_4 = DiaryEntry.new("07735444666")
        diary.add(entry_1)
        diary.add(entry_2)
        diary.add(entry_3)
        diary.add(entry_4)
        expect(diary.contact_lister).to eq ["07971300300", "07735444666"]
      end
    end

    context 'when given duplicate numbers' do
      it 'returns contained phone numbers only once' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met 0739 cats.")
        entry_3 = DiaryEntry.new("99999999999")
        entry_4 = DiaryEntry.new("07735444666")
        entry_5 = DiaryEntry.new("07735444666")
        diary.add(entry_1)
        diary.add(entry_2)
        diary.add(entry_3)
        diary.add(entry_4)
        diary.add(entry_5)
        expect(diary.contact_lister).to eq ["07971300300", "07735444666"]
      end
    end
  end

  describe '#find_readable' do
    context 'when no entries are readable' do
      it 'returns empty' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met cat.")
        diary.add(entry_1)
        diary.add(entry_2)
        expect(diary.find_readable(1,2)).to eq []
      end
    end

    context 'when no entries are readable' do
      it 'returns empty' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met cat.")
        diary.add(entry_1)
        diary.add(entry_2)
        expect(diary.find_readable(1,4)).to eq ["I met cat."]
      end
    end

    context 'when multiple entries are readable' do
      it 'returns the longest' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met some cats.")
        entry_3 = DiaryEntry.new("Cats.")
        diary.add(entry_1)
        diary.add(entry_2)
        diary.add(entry_3)
        expect(diary.find_readable(1, 5)).to eq ["I met some cats."]
      end
    end

    context 'when wpm or reading time is 0' do
      it 'fails with error' do
        diary = Diary.new
        entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
        entry_2 = DiaryEntry.new("I met some cats.")
        entry_3 = DiaryEntry.new("Cats.")
        diary.add(entry_1)
        diary.add(entry_2)
        diary.add(entry_3)
        expect { diary.find_readable(1, 0) }.to raise_error 'WPM & Reading time must be positive'
      end
    end
  end
end

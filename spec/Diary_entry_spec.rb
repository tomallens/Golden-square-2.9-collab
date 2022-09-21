require_relative '../lib/DiaryEntry'

describe DiaryEntry do
  it 'initializes' do
    entry_1 = DiaryEntry.new('woke up')
    expect(entry_1.view).to eq 'woke up'
  end

  describe '#word_counter' do
    context 'given a single word entry' do
      it 'returns 1' do
        entry_1 = DiaryEntry.new('woke')
        expect(entry_1.word_counter).to eq 1
      end
    end

    context 'given more than one word' do
      it 'counts them properly' do
        entry_1 = DiaryEntry.new('woke up and walked the milk')
        expect(entry_1.word_counter).to eq 6
      end
    end
  end
end
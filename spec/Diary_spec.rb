require_relative '../lib/Diary'

describe '#initialize' do
  it 'initializes' do
    diary = Diary.new
    expect(diary.view_all(DiaryEntry)).to eq []
  end

  it 'initializes' do
    diary = Diary.new
    expect(diary.view_all(Todo)).to eq []
  end
end

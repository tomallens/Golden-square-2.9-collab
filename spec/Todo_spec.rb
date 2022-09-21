require_relative '../lib/Todo'

describe Todo do
  it 'builds correctly' do
    todo = Todo.new('walk the milk')
    expect(todo.view).to eq 'walk the milk'
  end
end

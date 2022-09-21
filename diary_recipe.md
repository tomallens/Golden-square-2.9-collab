# {{Diary}} Multi-Class Planned Design Recipe

## 1. Describe the Problem

As a user
So that I can record my experiences
I want to keep a regular diary

As a user
So that I can reflect on my experiences
I want to read my past diary entries

As a user
So that I can reflect on my experiences in my busy day
I want to select diary entries to read based on how much time I have and my reading speed

As a user
So that I can keep track of my tasks
I want to keep a todo list along with my diary

As a user
So that I can keep track of my contacts
I want to see a list of all of the mobile phone numbers in all my diary entries


## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```

┌─────────────────────┐               │
│  Diary              │               ├─────────────────────────┐
│  add diary entry    │               │  Diary_entry            │
│                     │               │                         │
│  add todo           ├───────────────┘ text                    │
│                     │               ▲                         │
│  todo list          │               │ word count              │
│                     │               │                         │
│  extract and list   ├─────────────► │                         │
│   phone numbers     │               │                         │
│                     │               │                         │
└┬────────────────────┘               └─────────────────────────┘
 │returns diary entry
 │when given wpm and time
 │
 │
 │
 ▼
┌─────────────────────────┐
│ Todo task               │
│                         │
│ a task we want to do    │
│                         │
│ return text             │
│                         │

```

_Also design the interface of each class in more detail._

```ruby
class Diary

  def initialize 
  # with empty array for diary_entries
  # with empty array for todos
  end

  def add(class)
  # adds either diary_entry or todo instances to relevant array
  end

  def view_all(class)
   #returns entries or todo
  end


  def contact_lister
  # extract phone numbers from all diary_entries in the array
  # returns as list
  end

  def find_readable(wpm, time)
  # calculate and find largest readable diary_entry in the list
  # return it
  end
end

class DiaryEntry
  def initialize(entry) 
  # entry is just a string
  end

  def view
  # returns entry
  end

  def count_words
    # Returns integer of no. words in entry
  end
end

class Todo
  def initialize(task)
  #task is a string
  end
  
  def view
  #returns task
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# insert diary entries
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met cat.")
diary.add(entry_1)
diary.add(entry_2)
diary.view_all(DiaryEntry) # => [entry_1, entry_2]

# return readable entry
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met cat.")
diary.add(entry_1)
diary.add(entry_2)
diary.find_readable(1, 4) # => [entry_2]

# return readable entry
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met cat.")
diary.add(entry_1)
diary.add(entry_2)
diary.find_readable(1, 2) # => []

# return readable entry
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met some cats.")
entry_3 = DiaryEntry.new("Cats.")
diary.add(entry_1)
diary.add(entry_2)
diary.add(entry_3)
diary.find_readable(1, 5) # => [entry_2]

# returns a fail
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met cat.")
diary.add(entry_1)
diary.add(entry_2)
diary.find_readable(0, 0) # => [WPM & Reading time must be positive]

# extracts phone numbers
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met cat.")
diary.add(entry_1)
diary.add(entry_2)
diary.extract_numbers # => ["07971300300"]

# extracts phone numbers
diary = Diary.new
entry_1 = DiaryEntry.new("Today, I met Joe. His phone number is 07971300300")
entry_2 = DiaryEntry.new("I met 0739 cats.")
entry_3 = DiaryEntry.new("99999999999")
diary.add(entry_1)
diary.add(entry_2)
diary.add(entry_3)
diary.extract_numbers # => ["07971300300"]

# add todo
diary = Diary.new
todo_1 = Todo("Get that milk")
todo_2 = Todo("Get that bread")
diary.add(todo_1)
diary.add(todo_2)
diary.view(Todo) => [todo_1, todo_2]






```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby

#Unit tests 

#Diary
# diary = Diary.new
# diary.view_all => []

#Todo

todo = Todo.new("Get that milk")
todo.view => "Get that milk"

#Diary_entry view
entry = DiaryEntry.new("Got out of bed")
entry.view => "Got out of bed"

#Diary_entry count words
entry = DiaryEntry.new("Got out of bed")
entry.count_words => 4

```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._

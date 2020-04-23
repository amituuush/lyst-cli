require_relative "item"

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    Item.valid_date?(deadline) ? @items << Item.new(title, deadline, description) : false
  end

  def size
    @items.length
  end

  def valid_index?(index)
    index >= 0 && index < @items.length
  end

  def swap(index_1, index_2)
    return false unless valid_index?(index_1) || valid_index?(index_2)

    @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
    true
  end

  def [](index)
    return nil unless valid_index?(index)
    @items[index]
  end

  def priority
    @items.first
  end

  def print
    p "-------------------------------------------"
    p "       #{@label}".ljust(42)
    p "-------------------------------------------"
    p "Index | Item         | Deadline     | Done "
    p "-------------------------------------------"
    @items.each_with_index do |item, i|
      p "#{i}".ljust(6) + "| #{item.title}".ljust(15) + "| #{item.deadline}".ljust(15) + "| #{item.done}"
    end
    p "-------------------------------------------"
  end

  def print_full_item(index)
    item = @items[index]
    p "----------------------------------------"
    p "#{item.title}".ljust(29) + "#{item.deadline}"
    p "#{item.description}".ljust(29) + "Done: #{item.done}"
    p "----------------------------------------"
  end

  def print_priority
    print_full_item(0)
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end

  def toggle_item(index)
    @items[index].toggle
  end
end
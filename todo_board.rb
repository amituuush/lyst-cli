require_relative "list"
require "byebug"

class TodoBoard
  def initialize
    @lists = {}
  end

  def make_list(label)
    @lists[label] = List.new(label)
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split(" ")

    case cmd
    when "mklist", "ml"
      make_list(*args.first)
    when "ls"
      @lists.keys.each { |key| print "#{key} " }
    when "mktodo", "mt"
      label, *rest = args
      if @lists.key?(label)
        @lists[label].add_item(*rest) ? true : p("invalid date format, must be yyyy-mm-dd")
      else
        p("list does not exist")
      end
    when "showall", "sa"
      @lists.values.each { |list| list.print }
    when "toggle", "t"
      label, *index = args
      @lists[label].toggle_item(index.first.to_i)
    when "rm"
      label, *index = args
      @lists[label].remove_item(index.first.to_i)
    when "purge"
      label, *rest = args
      @lists[label].purge
    when "swap"
      label, index_1, index_2 = args
      @lists[label].swap(index_1.to_i, index_2.to_i)
    when "sort"
      label, *rest = args
      @lists[label].sort_by_date!
    when "priority"
      label, *rest = args
      @lists[label].print_priority
    when "print" || "p"
      return false if args.empty?
      label, *indices = args
      indices.empty? ? @lists[label].print : @lists[label].print_full_item(indices.first.to_i)
    when "quit"
      return false
    else
      print "Sorry, that command is not recognized."
      true
    end
  end

  def run
    loop do
      break if !get_command
    end
  end
end

todo_board = TodoBoard.new
todo_board.run
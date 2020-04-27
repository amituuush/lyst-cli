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
    cmd, label, *args = gets.chomp.split(" ")

    case cmd
    when "mklist", "ml"
      make_list(label)
    when "ls"
      @lists.keys.each { |key| print "#{key} " }
    when "mktodo", "mt"
      if @lists.key?(label)
        @lists[label].add_item(*args) ? true : p("invalid date format, must be yyyy-mm-dd")
      else
        p("list does not exist")
      end
    when "showall", "sa"
      @lists.values.each { |list| list.print }
    when "toggle", "t"
      @lists[label].toggle_item(args.first.to_i)
    when "rm"
      @lists[label].remove_item(args.first.to_i)
    when "purge"
      @lists[label].purge
    when "swap"
      index_1, index_2 = args
      @lists[label].swap(index_1.to_i, index_2.to_i)
    when "sort"
      @lists[label].sort_by_date!
    when "priority"
      @lists[label].print_priority
    when "print" || "p"
      if label.nil?
        p "please enter a label to print along with an optional index"
      else
        args.empty? ? @lists[label].print : @lists[label].print_full_item(args.first.to_i)
      end
    when "quit", "q"
      return false
    when "help", "h"
      help
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

  def help
    puts "
    Thanks for trying out Lyst CLI!
    Below is a list of available commands: \n
    mklist <new_list_label>
      - make a new list with the given label
      - alias: ml \n
    ls
      - print the labels of all lists \n
    showall
      - print all lists
       - alias: sa \n
    mktodo <list_label> <item_title> <item_deadline> <optional_item_description>
      - add a new item to the specified list with the given information
      - alias: mt \n
    toggle <list_label> <item_index>
      - toggle 'done' for the specified item on the given list
      - alias: t \n
    rm <list_label> <item_index>
      - remove the specified item on the given list \n
    purge <list_label>
      - remove all 'done' items on the given list \n
    up <list_label> <item_index> <optional_amount>
      - move the specified item higher on the given list \n
    down <list_label> <item_index> <optional_amount>
      - move the specified item higher on the given list \n
    swap <list_label> <item_index_1> <item_index_2>
      - swap the positions of the specified items on the given list \n
    sort <list_label>
      - sort the given list by deadline \n
    priority <list_label>
      - print the all information for the item at the top of the given list \n
    print <list_label> <optional_index>
      - print all items of the given list if index is not provided
      - print the specific item of the given list if index is provided
      - alias: p \n
    quit
      - exit program
      - alias: q
    help
      - show current list of commands
      - alias: h
      "
  end
end

todo_board = TodoBoard.new
todo_board.run
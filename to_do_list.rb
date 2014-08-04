require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "Welcome to the To Do List!"
  menu
end

def menu
  loop do
  puts "1. enter a task \n
        2. create a list\n
        x. exit"
  user_choice = gets.chomp

    if user_choice == '1'
      enter_task
    elsif user_choice == '2'
      create_list
    elsif user_choice == 'x'
      puts "Goodbye"
      break
    end
  end
end

def create_list
  puts "Enter list title"
  list_title = gets.chomp
  new_list = List.new(list_title)
  new_list.save
end

def enter_task
  List.all.each do |item|
    puts item.name
    puts item.id
  end
  puts "What list would you like to add a task to?"
  user_choice = gets.chomp

  List.all.each do |item|
    if user_choice == item.name
      puts "Enter task name"
      user_task = gets.chomp
      new_task = Task.new(user_task, item.id)
      new_task.save
      puts new_task.name
    end
  end
end

menu

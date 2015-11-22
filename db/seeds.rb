require "factory_girl_rails"

puts "Creating Tasks"

puts "Regular Lists: "
10.times do
  new_list = FactoryGirl.create(:list)
  puts new_list.title
end

puts "Archived Lists: "
3.times do
  new_archived_list = FactoryGirl.create(:archived_list)
  puts new_archived_list.title
end

puts "Lists with Completed Tasks: "
3.times do
  new_list_with_completed_tasks = FactoryGirl.create(:list_with_completed_tasks)
  puts new_list_with_completed_tasks.title
end

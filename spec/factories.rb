require 'faker'
require 'byebug'

FactoryGirl.define do

  factory :user do
    id { 1 }
    username { "noobjey" }
    uid { "8325508" }
    token { "b78f89a9870f3bd00587c5d445c8ab82b953e51f" }
  end


  factory :list do
    title { Faker::Team.name }
    user_id { 1 }

    factory :archived_list do
      archive true
    end

    transient do
      tasks_count 5
    end

    after(:create) do |list, evaluator|
      create_list(:task, evaluator.tasks_count, list: list)
    end
  end


  factory :list_with_completed_tasks, parent: :list do
    after(:create) do |list, evaluator|
      create_list(:completed_tasks, evaluator.tasks_count, list: list)
    end
  end


  factory :task do
    title { Faker::Hacker.ingverb }
    description { Faker::Hacker.say_something_smart }
    due_date { Faker::Date.forward(rand(200)) }
    list

    factory :completed_tasks do
      status true
    end
  end
end

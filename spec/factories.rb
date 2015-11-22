require 'faker'
require 'byebug'

FactoryGirl.define do

  factory :list do
    title { Faker::Team.name }

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
    title { Faker::Team.name }

    transient do
      tasks_count 5
    end

    after(:create) do |list, evaluator|
      create_list(:completed_tasks, evaluator.tasks_count, list: list)
    end
  end


  factory :task do
    title { Faker::Hacker.ingverb }
    description { Faker::Hacker.say_something_smart }
    due_date { Faker::Date.forward(rand(20)) }
    list

    factory :completed_tasks do
      status true
    end
  end
end

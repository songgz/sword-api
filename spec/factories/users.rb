# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    userid {Faker::IDNumber.brazilian_id}
    password {'540512'}


  end
end

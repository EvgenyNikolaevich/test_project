# frozen_string_literal: true

FactoryBot.define do
  factory :rate, class: 'Domains::Rate::Entity' do
    rate    { 1 }
    post_id { 1 }

    initialize_with do
      Domains::Rate::Entity.new(
        rate: rate,
        post_id: post_id
      )
    end

    to_create do |instance|
      Domains::Rate::Repository.new.create(instance)
    end
  end
end

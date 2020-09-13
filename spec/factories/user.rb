# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'Domains::User::Entity' do
    login { 'Awesome User' }

    initialize_with { Domains::User::Entity.new(login: login) }

    to_create do |instance|
      Domains::User::Repository.new.create(instance)
    end
  end
end

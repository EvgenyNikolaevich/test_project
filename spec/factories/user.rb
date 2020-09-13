# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user, class: 'Domains::User::Entity' do
    login { SecureRandom.hex }

    initialize_with { Domains::User::Entity.new(login: login) }

    to_create do |instance|
      Domains::User::Repository.new.create(instance)
    end
  end
end

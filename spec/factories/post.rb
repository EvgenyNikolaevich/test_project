# frozen_string_literal: true

FactoryBot.define do
  factory :post, class: 'Domains::Post::Entity' do
    title     { 'My first day at work' }
    article   { 'Today is a great day, because...' }
    author_ip { '127.0.0.1' }
    user_id   { 1 }

    initialize_with do
      Domains::Post::Entity.new(
        author_ip: author_ip,
        title: title,
        article: article,
        user_id: user_id
      )
    end

    to_create do |instance|
      Domains::Post::Repository.new.create(instance)
    end
  end
end

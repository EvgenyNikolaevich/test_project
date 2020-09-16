# frozen_string_literal: true

FactoryBot.define do
  factory :post, class: 'Domains::Post::Entity' do
    title        { 'My first day at work' }
    article      { 'Today is a great day, because...' }
    author_ip    { '127.0.0.1' }
    author_login { 'Krendel' }
    id           { rand(1..1000) }

    initialize_with do
      Domains::Post::Entity.new(
        author_ip: author_ip,
        title: title,
        article: article,
        author_login: author_login
      )
    end

    to_create do |instance|
      Domains::Post::Repository.new.create(instance)
    end
  end
end

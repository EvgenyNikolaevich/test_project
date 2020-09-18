# frozen_string_literal: true

require 'faker'
require 'sequel/core'

module SeedHelper
  def create_and_save_records
    logins = generate_logins
    ips    = generate_ips
    posts  = generate_posts(logins, ips)

    save_logins(logins)
    save_posts(posts)
  end

  def generate_logins
    100.times.each_with_object([]) do |_index, values|
      values << "('#{Faker::Name.unique.first_name}')"
    end
  end

  def generate_ips
    50.times.each_with_object([]) do |_index, values|
      values << Faker::Internet.ip_v4_address
    end
  end

  def generate_posts(logins, ips)
    200_000.times.each_with_object([]) do |_index, values|
      title        = Faker::Lorem.word
      article      = Faker::Lorem.sentence(word_count: 3)
      author_ip    = ips.sample
      author_login = logins.sample.gsub(/[()']/, '')
      values << "('#{title}', '#{article}', '#{author_ip}', '#{author_login}')"
    end
  end

  def save_logins(values)
    client.run("INSERT INTO users (login) values #{values.join(',')}")
  end

  def save_posts(values)
    client.run("INSERT INTO posts (title, article, author_ip, author_login) values #{values.join(',')}")
  end

  def client
    @client ||= Sequel.connect(DB_CONF)
  end
end

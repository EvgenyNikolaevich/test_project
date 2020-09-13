# frozen_string_literal: true

require 'sequel'

DB = Sequel.connect(DB_CONF).tap do |connection|
  connection.timezone = :utc
end

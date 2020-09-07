# frozen_string_literal: true

require 'yaml'
require 'erb'

APP_CONF = YAML.load(ERB.new(File.read(File.join(APP_ROOT, 'config', 'application.yml'))).result)[APP_ENV] # rubocop:disable Security/YAMLLoad
DB_CONF = YAML.load(ERB.new(File.read(File.join(APP_ROOT, 'config', 'database.yml'))).result)[APP_ENV] # rubocop:disable Security/YAMLLoad

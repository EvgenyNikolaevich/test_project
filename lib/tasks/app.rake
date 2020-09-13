# frozen_string_literal: true

namespace :app do
  desc 'Open a pry session with this library'
  task :console do
    require 'irb'
    require_relative '../../config/boot'

    ARGV.clear
    IRB.start
  end

  desc 'Run server with code reloading, preloaded with this library, at port 5010'
  task :server do
    exec 'rerun "puma config.ru --port=5010" --background'
  end
end

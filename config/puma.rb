# frozen_string_literal: true

# Puma config

daemonize false

# Store the pid of the server in the file at "path".
#
pidfile String(ENV['PUMA_PID'] || './tmp/pids/puma.pid')

# Use "path" as the file to store the server info state. This is
# used by "pumactl" to query and control the server.
#
state_path String(ENV['PUMA_STATE'] || './tmp/pids/puma.state')

# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
#
# The default is "0, 16".
#
threads 1, Integer(ENV['PUMA_MAX_THREADS'] || 10)

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".
bind String(ENV['PUMA_BIND'] || 'tcp://0.0.0.0:9292')

# === Cluster mode ===

# How many worker processes to run.  Typically this is set to
# to the number of available cores.
#
# The default is "0".
#
workers Integer(ENV['PUMA_WORKERS'] || 1)

# Preload the application before starting the workers; this conflicts with
# phased restart feature. (off by default)

preload_app!

# Verifies that all workers have checked in to the master process within
# the given timeout. If not the worker process will be restarted. This is
# not a request timeout, it is to protect against a hung or dead process.
# Setting this value will not protect against slow requests.
# Default value is 60 seconds.
#
worker_timeout 60

# Change the default worker timeout for booting
#
# If unspecified, this defaults to the value of worker_timeout.
#
worker_boot_timeout 60

before_fork do
  # DB.disconnect
  #
  if defined?(::Sequel)
    Thread.current[:sequel_connect_options] = ::Sequel::DATABASES.map do |db|
      db.disconnect
      db.opts[:orig_opts]
    end
  end
end

on_worker_boot do
  if defined?(::Sequel)
    Thread.current[:sequel_connect_options].each do |orig_opts|
      ::Sequel.connect(orig_opts)
    end
  end
end

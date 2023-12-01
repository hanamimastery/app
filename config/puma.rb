# frozen_string_literal: true

development = ENV.fetch('HANAMI_ENV', 'development') == 'development'

require 'concurrent'
require 'localhost' if development
Bundler.require :tools if development


#
# Threads within each Puma/Ruby process (aka worker)
#

# Configure the minimum and maximum number of threads to use to answer requests.
max_threads_count = ENV.fetch('HANAMI_MAX_THREADS', 5)
min_threads_count = ENV.fetch('HANAMI_MIN_THREADS') { max_threads_count }

threads min_threads_count, max_threads_count

#
# Environment and port
#
port ENV.fetch('HANAMI_PORT', 2300)
environment ENV.fetch('HANAMI_ENV', 'development')

#
# Workers (aka Puma/Ruby processes)
#

# How many worker (Puma/Ruby) processes to run.
# Typically this is set to the number of available cores.
puma_concurrency = Integer(ENV.fetch('HANAMI_WEB_CONCURRENCY', Concurrent.physical_processor_count))

workers puma_concurrency

worker_timeout 3600 if development
ssl_bind 'localhost', '9050' if development
pidfile ENV.fetch 'PIDFILE', 'tmp/server.pid'
plugin :tmp_restart

#
# Cluster mode (aka multiple workers)
#
puma_cluster_mode = puma_concurrency > 1
if puma_cluster_mode
  # Preload the application before starting the workers. Only in cluster mode.
  preload_app!

  # Code to run immediately before master process forks workers (once on boot).
  #
  # These hooks can block if necessary to wait for background operations unknown
  # to puma to finish before the process terminates. This can be used to close
  # any connections to remote servers (database, redis, …) that were opened when
  # preloading the code.
  before_fork do
    Hanami.shutdown
  end
else
  on_worker_boot { Hanami.shutdown }
  preload_app!
end

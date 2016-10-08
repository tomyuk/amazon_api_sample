# -*- coding: utf-8 -*-
#----------------------------------------
# Setup for Rack

module Rails
  class Server # < ::Rack::Server
    #
    # Default settings for Rack Server
    #
    def default_options
      super.merge({
                    Port: 3000,
                    DoNotReverseLookup:  true,
                    environment:  (ENV['RAILS_ENV'] || ENV['RACK_ENV'] || "development").dup,
                    daemonize:    false,
                    debugger:     false,
                    pid:          File.expand_path("tmp/pids/server.pid"),
                    config:       File.expand_path("config.ru")
                  })
    end
  end
end

require 'uri'
require 'json'
require 'date'
require 'colorize'
require 'eventmachine'
require 'faye/websocket'

require "riemann/tail/config"
require "riemann/tail/version"

module Riemann
  module Tail
    def self.configure(&block)
      yield @config = Config.new
    end

    def self.run_query(query, options)
      url = "ws://#{options["host"]}:#{options["port"]}/index?subscribe=true&query=#{URI.encode(query)}"

      EM.run do
        ws = Faye::WebSocket::Client.new(url)

        ws.on :error do |e|
          puts "error... #{e.to_s}".red
          Process.exit 1
        end

        ws.on :close do |e|
          Process.exit 0
        end

        ws.on :message do |m|
          event = JSON.parse(m.data).reduce(@config.defaults.clone) do |o, (k, v)|
            if k == "time"
              v = DateTime.parse(v).to_time
            end

            if fs = @config.formatters[k.to_sym]
              v = fs[:block].call(v) if fs[:block]
              v = fs[:methods].reduce(v) { |r, s| r.send(s) } if fs[:methods]
            end

            o[k.to_sym] = v
            o
          end

          puts @config.line_format % event
        end
      end
    end
  end
end

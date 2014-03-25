# Riemann::Tail

Subscribe to (tail) [Riemann](http://riemann.io "Riemann") event streams from the console.

## Installation

Add this line to your application's Gemfile:

    gem 'riemann-tail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riemann-tail

## Usage

`riemann-tail --help`

    Usage:
      riemann-tail QUERY

    Options:
      h, [--host=HOST]                    # Riemann host
                                          # Default: localhost
      p, [--port=PORT]                    # Riemann port number
                                          # Default: 5556
      c, [--config=CONFIG]                # Path to config file
                                          # Default: riemann-tail-config.rb
      f, [--from-file], [--no-from-file]  # Read query from file instead of command

    Subscribe to (tail) a riemann event stream based on QUERY

Example configuration file (provided as `riemann-tail-config.rb`)

    Riemann::Tail.configure do |c|
      c.format :host, :blue
      c.format :metric, [:to_s, :cyan]

      c.format :tags, :light_black do |t|
        t.join(", ")
      end

      c.format :time, :light_black do |t|
        t.localtime.strftime("%T")
      end

      c.format :state, [:downcase, :bold] do |s|
        case s
        when /fail|err/i then s.red
        when /warn/i then s.yellow
        else s.green
        end
      end

      c.line_format = "%{time}#{">".light_black} %{state} %{host} %{service} %{tags} %{metric}\n        #{">".light_black} %{description}"
    end

Example query file (provided as `query.clj`)

    tagged "log"

## Contributing

1. Fork it ( http://github.com/<my-github-username>/riemann-tail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

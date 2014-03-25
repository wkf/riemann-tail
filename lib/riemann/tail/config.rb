module Riemann
  module Tail
    class Config
      def initialize
        @defaults = {}
        @formatters = {}
      end

      attr_accessor :line_format, :formatters, :defaults

      def format(field, format, &block)
        @formatters[field.to_sym] = {
          methods: (format.is_a?(Array) ? format : [format.to_sym])
        }
        @formatters[field.to_sym][:block] = block if block_given?
      end

      def default(field, value)
        @defaults[field.to_sym] = value.to_s
      end

      def line_format=(format)
        # hacky way to prevent sprintf (%) from throwing key errors
        format.scan(/%{([^}]+)}|%<([^>])>/).each do |(m, n)|
          @defaults[(m||n).to_sym] ||= ""
        end
        @line_format = format
      end
    end
  end
end

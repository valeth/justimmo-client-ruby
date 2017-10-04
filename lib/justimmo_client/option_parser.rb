# frozen_string_literal: true

module JustimmoClient
  # @api private
  class OptionParser
    include JustimmoClient::Logging

    attr_accessor :range_suffix
    attr_accessor :mappings

    def initialize(options = {})
      @options = options
      @mappings = {}
      @range_suffix = %i[_min _max]
      @context = nil

      yield self if block_given?

      parse unless options.empty?
    end

    def add(key, **options, &block)
      add_option(key, options, &block)
    end

    def group(groupname)
      @context = groupname.to_sym
      yield self if block_given?
      @context = nil
    end

    def parse(options = {})
      out = {}

      options.each do |key, value|
        raise ArgumentError, "Invalid option: #{key}" unless @options.key?(key.to_sym)
        group = group_of(key)

        if group
          out[group] ||= {}
          out[group].update(parse_option(key.to_sym, value))
        else
          out.update(parse_option(key.to_sym, value))
        end
      end

      out
    end

    private

    def add_option(key, **options, &block)
      @options[key.to_sym] = {
        group: @context,
        type: options[:type],
        as: options[:as],
        values: options[:values],
        mod: block_given? ? block : nil
      }
    end

    def group_of(key)
      @options.dig(key, :group)
    end

    def has_mod?(key)
      @options.dig(key, :mod).is_a?(Proc)
    end

    def apply_mod(key, value)
      new_key, new_value = @options.dig(key, :mod).call(key, value)
      [(new_key || key), (new_value || value)]
    end

    def mapping(key)
      @mappings.fetch(key, key)
    end

    def translate(key)
      return @options[key][:as] if @options[key][:as]

      suffix =
        case key
        when /(.*)_min/ then @range_suffix.first
        when /(.*)_max/ then @range_suffix.last
        when /(.*)_id/  then "_id"
        else nil
        end

      key = ($1 || key).to_sym

      "#{mapping(key)}#{suffix}".to_sym
    end

    def parse_option(key, value)
      values = @options.dig(key, :values)
      raise ArgumentError, "Value #{value} not supported" unless values.nil? || values.include?(value)

      key, value = apply_mod(key.to_sym, value) if has_mod?(key)

      coerced =
        case @options.dig(key, :type)
        when :bool then i_to_bool(value)
        else mapping(value)
        end

      { translate(key) => coerced }
    end

    def parse_range(key, range)
      min, max  = @options[key][:range_suffix]
      api_param = @options[key][:mapped]
      { "#{api_param}#{min}": range.first, "#{api_param}#{max}": range.last }
    end

    def i_to_bool(value)
      value ? 1 : 0
    end
  end
end

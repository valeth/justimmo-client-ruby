require 'active_support/core_ext/string/inflections' # underscore
require 'active_support/core_ext/string/conversions' # to_date
require 'nokogiri'

module Justimmo
  module Parser
    # Convert a XML document to a Ruby hash.
    # @param  data [String]  The XML string to convert
    # @return  [Hash]  A converted structure or an empty hash
    def self.parse(data)
      return {} unless data.is_a?(String)

      doc = Nokogiri::XML(data) do |config|
        config.noblanks
        config.norecover
        config.nonet
      end

      doc.to_h
    rescue Nokogiri::XML::SyntaxError => e
      Logger.error("Failed to parxe XML document: #{e}")
      {}
    end
  end

  module Conversions
    module Document
      def to_h
        root.to_h
      end
    end

    module Node
      def to_h(hash = {})
        node_hash = {}
        node_name = format_key(name)

        attribute_nodes.each { |a| a.to_h(node_hash) }

        children.each do |c|
          if c.element?
            c.to_h(node_hash)
          elsif node_hash.empty?
            node_hash = parse_value(c.content)
          else
            node_hash[:value] = parse_value(c.content)
          end
        end

        node_hash = nil if node_hash == {}

        # Insert into parent hash
        case hash[node_name]
        when Array then hash[node_name] << node_hash
        when Hash  then hash[node_name] = [hash[node_name], node_hash]
        when nil   then hash[node_name] = node_hash
        else            hash[node_name] = [hash[node_name], node_hash]
        end

        hash
      end

      def parse_value(value)
        case value
        when /^\d*\.\d+$/ then value.to_f
        when /^\d+$/ then value.to_i
        when 'true' then true
        when 'false' then false
        when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/ then value.to_date
        else value
        end
      end

      def format_key(key)
        key.underscore.to_sym
      end
    end

    module Attr
      def to_h(hash = {})
        hash[format_key("@#{name}")] = parse_value(value)
      end
    end
  end

  Nokogiri::XML::Document.include(Conversions::Document)
  Nokogiri::XML::Node.include(Conversions::Node)
  Nokogiri::XML::Attr.include(Conversions::Attr)
end

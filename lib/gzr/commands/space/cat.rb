# frozen_string_literal: true

require_relative '../../command'
require_relative '../../modules/space'
require_relative '../../modules/filehelper'
require 'zlib'

module Gzr
  module Commands
    class Space
      class Cat < Gzr::Command
        include Gzr::Space
        include Gzr::FileHelper
        def initialize(space_id, options)
          super()
          @space_id = space_id
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          say_warning("options: #{@options.inspect}") if @options[:debug]
          with_session do
            data = query_space(@space_id)
            write_file(@options[:dir] ? "Space_#{data.id}_#{data.name}.json" : nil, @options[:dir], nil, output) do |f|
              f.puts JSON.pretty_generate(data.to_attrs)
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../../command'
require_relative '../../modules/connection'
require 'tty-table'

module Gzr
  module Commands
    class Connection
      class Dialects < Gzr::Command
        include Gzr::Connection
        def initialize(options)
          super()
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          say_warning(@options) if @options[:debug]
          with_session do
            data = query_all_dialects(@options[:fields])
            begin
              say_ok "No dialects found"
              return nil
            end unless data && data.length > 0

            table_hash = Hash.new
            fields = field_names(@options[:fields])
            table_hash[:header] = data[0].to_attrs.keys unless @options[:plain]
            expressions = fields.collect { |fn| field_expression(fn) }
            table_hash[:rows] = data.map do |row|
              expressions.collect do |e|
                eval "row.#{e}"
              end
            end
            table = TTY::Table.new(table_hash)
            alignments = fields.collect do |k|
              (k =~ /id$/) ? :right : :left
            end
            begin
              if @options[:csv] then
                output.puts render_csv(table)
              else
                output.puts table.render(if @options[:plain] then :basic else :ascii end, alignments: alignments)
              end
            end if table
          end
        end
      end
    end
  end
end

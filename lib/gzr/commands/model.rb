# frozen_string_literal: true

require_relative 'subcommandbase'

module Gzr
  module Commands
    class Model < SubCommandBase

      namespace :model

      desc 'ls', 'List the models in this server.'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      method_option :fields, type: :string, default: 'name,label,project_name',
                           desc: 'Fields to display'
      method_option :plain, type: :boolean, default: false,
                           desc: 'print without any extra formatting'
      method_option :csv, type: :boolean, default: false,
                           desc: 'output in csv format per RFC4180'
      def ls(*)
        if options[:help]
          invoke :help, ['ls']
        else
          require_relative 'model/ls'
          Gzr::Commands::Model::Ls.new(options).execute
        end
      end
    end
  end
end

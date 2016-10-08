# -*- coding: utf-8; mode: ruby -*-

#require(File.expand_path('config/environment.rb', Rails.root.to_s))
#require 'factory_girl'

module ActionDispatch
  module Routing
    class CsvFormatter # :nodoc:
      def initialize
        @buffer = []
      end

      def result
        @buffer.join("\n")
      end

      def section_title(title)
        @buffer << "\n#{title}:"
      end

      def section(routes)
        @buffer << draw_section(routes)
      end

      def header(routes)
        @buffer << draw_header(routes)
      end

      def no_routes
                @buffer << <<-MESSAGE.strip_heredoc
          You don't have any routes defined!

          Please add some routes in config/routes.rb.

          For more information about routes, see the Rails guide: http://guides.rubyonrails.org/routing.html.
          MESSAGE
      end

      private
      def draw_section(routes)
        name_width, verb_width, path_width = widths(routes)

        routes.map do |r|
          "#{r[:name]},#{r[:verb]},#{r[:path]},#{r[:reqs]}"
        end
      end

      def draw_header(routes)
        name_width, verb_width, path_width = widths(routes)

        "Prefix,Verb,URI Pattern,Controller#Action"
      end

      def widths(routes)
        [routes.map { |r| r[:name].length }.max,
         routes.map { |r| r[:verb].length }.max,
         routes.map { |r| r[:path].length }.max]
      end
    end
  end
end

namespace :routes do
  desc 'ルーティングを CSV 形式で出力する'
  task csv: [:environment] do
    all_routes = Rails.application.routes.routes
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    puts inspector.format(ActionDispatch::Routing::CsvFormatter.new, ENV['CONTROLLER'])
  end
end


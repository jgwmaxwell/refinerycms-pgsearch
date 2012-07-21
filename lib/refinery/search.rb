require "refinerycms-core"

module Refinery
  autoload :SearchGenerator, 'generators/refinery/search/search_generator'

  module Search
    require "refinery/search/engine"

    class << self
      attr_writer :root
      mattr_accessor :searchable_models

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def configure
        yield self
      end
    end
  end
end


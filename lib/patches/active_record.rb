# Class to provide active_record w/ a method to initialize models associated w/ another model
#
# Use this in models to state that the given associated object
# should always be present, and be built implicitly if it isn't.
#
# Example:
#
#   class Foo < ActiveRecord::Base
#     belongs_to :bar
#     initializes :bar
#   end
#
#   # No `bar' present -> one is built:
#   foo = Foo.new
#   foo.bar.nil?       #=> false
#   foo.bar.is_a?(Bar) #=> true
#
#   # `bar' is present -> regular AR behavior:
#   bar = Bar.new
#   foo = Foo.new(bar: bar)
#   foo.bar.object_id == bar.object_id #=> true
#
class << ActiveRecord::Base
  def initializes *things
    @initializes ||= []
    things.each { |thing| @initializes << [ thing.to_sym, "build_#{thing}".to_sym ] }
    include Initializes unless included_modules.include?(Initializes)
  end

  def _initializes
    @initializes || []
  end

  # Monkey-patch initialize
  module Initializes
    def initialize *args
      super *args
      self.class._initializes.each do |(thing, builder)|
        __send__ builder unless __send__ thing
      end
    end
  end

end

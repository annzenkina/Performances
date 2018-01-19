class Event < ApplicationRecord
  after_destroy :print_something

  def print_something
    print "I AM BEING DESTROY"
  end
end

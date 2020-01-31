class CounterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    # tutorial
    21 + 21

  end
end

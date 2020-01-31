class PagesController < ApplicationController
  def home

    # tutorial
    # We are executing the job on the spot rather than in the background to
    # exercise using Sidekiq in a trivial example.
    #
    # Consult with the Rails documentation to learn more about Active Job:
    # http://edgeguides.rubyonrails.org/active_job_basics.html
    @meaning_of_life = CounterJob.perform_now

  end
end

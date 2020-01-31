require 'test_helper'

class CounterJobTest < ActiveJob::TestCase

  # tutorial
  # test "the truth" do
  #   assert true
  # end
  test "returns 42" do
     assert_equal 42, CounterJob.perform_now
  end

end

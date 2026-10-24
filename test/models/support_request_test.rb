require "test_helper"

class SupportRequestTest < ActiveSupport::TestCase
  test "support request can belong to an order optionally" do
    support_request = SupportRequest.new(
      email: "customer@example.com",
      subject: "I need help!",
      body: "I can't find my order. It's #12345"
    )

    assert support_request.valid?
    assert_nil support_request.order
  end
end

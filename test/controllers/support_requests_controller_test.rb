require "test_helper"

class SupportRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)

    @support_request = SupportRequest.create!(
      email: "customer@example.com",
      subject: "I need help!",
      body: "I can't find my order. It's #12345"
    )
  end

  test "should get index" do
    get support_requests_url
    assert_response :success
  end

  test "should update response and send email" do
    assert_emails 1 do
      patch support_request_url(@support_request), params: {
        support_request: {
          response: "Here is the answer to your question."
        }
      }
    end

    @support_request.reload
    assert_equal "Here is the answer to your question.",
                 @support_request.response.to_plain_text
    assert_redirected_to support_requests_url
  end
end

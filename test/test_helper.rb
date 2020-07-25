ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module SignInHelper
  def sign_in_as_default
    post login_url(user: { username: users(:one).username, password: users(:one).password })
  end
end

class ActiveSupport::TestCase
  include SignInHelper

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def body(response)
    JSON.parse(response.body)
  end

  def combine_bookone_and_3words
    books(:book_one).words << words(:words_one) << words(:words_two) << words(:words_three)
  end
end

class ApplicationController < ActionController::Base
  helper_method :current # Expose to views
  delegate :timezone, to: :current # Creates a `timezone` method on the controller that calls current.timezone
  around_action :timezone # Wraps the request context within the users timezone.

  protected

  def current
    @current ||= Current.new.tap { |current| current.user = demo_user }
  end

  def demo_user
    # In reality, we'd pull this from User.find(session[:user_id]),
    # but since this is throw away, I'm going to create everything inline here.
    User.create_or_find_by(name: "Brad", timezone: "Eastern Time (US & Canada)").tap do |user|
      user.account ||= Account.create!
    end
  end
end

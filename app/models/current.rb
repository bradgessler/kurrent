class Current
  attr_accessor :account, :user, :request_id, :user_agent, :ip_address

  def user=(user)
    @user = user
    self.account = user.account
  end

  def timezone
    user.timezone.tap do |tz|
      if block_given?
        Time.zone = tz
        yield
        Time.zone = nil
      end
    end
  end

  def save(model, params = {})
    model.assign_attributes params
    model.creator = user
    model.account = account
    model.events.build \
      request_id: request_id,
      ip_address: ip_address,
      user_agent: user_agent
    model.save
  end
end

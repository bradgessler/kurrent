module AuditedSave
  extend ActiveSupport::Concern

  protected

  def save(model, params = {})
    model.assign_attributes params
    assign_current model
    model.events.build \
      request_id: request.uuid,
      ip_address: request.ip,
      user_agent: request.user_agent
    model.save
  end

  def assign_current(model)
    model.creator = current.user
  end
end
class AlertsController < ApplicationController
  before_action :forbid_not_login_user
  before_action :alert_inform
  
  def index
    @alerts = current_user.alerts.order(id: :desc).page(params[:page])
    @alerts.each do |alert|
      alert.update(checked: "read")
    end
  end
  
end

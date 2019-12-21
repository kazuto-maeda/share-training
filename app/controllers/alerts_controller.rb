class AlertsController < ApplicationController
  before_action :forbid_not_login_user
  before_action :alert_inform
  
  def index
    @alerts = Alert.order(id: :desc).where("(alerted = ?) AND (user_id != ?)",current_user.id, current_user).page(params[:page])
    @alerts.where(checked: 0).each do |alert|
      alert.update(checked: 1)
    end 
  end
end

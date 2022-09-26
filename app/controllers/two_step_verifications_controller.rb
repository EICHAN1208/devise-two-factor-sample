class TwoStepVerificationsController < ApplicationController
  before_action :authenticate_user!

  # QRコード表示用のuriを返す
  def new
    unless current_user.otp_secret
      current_user.update!(otp_secret: User.generate_otp_secret(32))
    end

    issuer = 'YourAppName'
    label = "#{issuer}:#{current_user.email}"

    uri = current_user.otp_provisioning_uri(label, issuer: issuer)
    render json: { uri: uri }
  end

  # 2段階認証有効化
  def create
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
      current_user.update!(otp_required_for_login: true)

      head :ok
    else
      render json: { errors: current_user.errors }, status: :bad_request
    end
  end

  # 2段階認証無効化
  def destroy
    current_user.update!(otp_required_for_login: false)
    head :ok
  end
end

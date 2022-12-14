module Auth
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    def redirect_callbacks
      super
    end

    def omniauth_success
      super
    end

    def omniauth_failure
      super
    end

    protected
    def assign_provider_attrs(user, auth_hash)
      case auth_hash['provider']
      when 'twitter'
        user.assign_attributes({
          name: auth_hash['info']['name'],
          image: auth_hash['info']['image'],
          email: auth_hash['info']['email']
        })
      else
        super
      end
    end

    def render_data_or_redirect(message, data, user_data = {})
      if Rails.env.production?
        if ['inAppBrowser', 'newWindow'].include?(omniauth_window_type)
          render_data(message, user_data.merge(data))
        elsif auth_origin_url
          redirect_to DeviseTokenAuth::Url.generate(auth_origin_url, data.merge(blank: true))
        else
          fallback_render data[:error] || 'An error occurred'
        end
      else
        render json: @resource, status: :ok
      end
    end
  end
end

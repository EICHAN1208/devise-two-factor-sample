# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
  include DeviseTokenAuth::Concerns::User
end

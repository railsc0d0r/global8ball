#
# Contains convinience method fetching all attributes concerning an user from given hash
# and giving them back as hash.
# Needed because of nested structure of concerned models
#
module UserAttributesConcern
  extend ActiveSupport::Concern

  included do
    def fetch_user_attributes params_hash
      raise "Given argument is not a hash" unless params_hash.class == ActionController::Parameters

      {
          role_name: params_hash.delete(:role_name),
          password: params_hash.delete(:password),
          password_confirmation: params_hash.delete(:password_confirmation)
      }
    end
  end
end

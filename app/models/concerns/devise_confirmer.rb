module DeviseConfirmer
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_digested_confirm_token(confirmation_token)
      return unless confirmation_token.present?
      # ここ違った
      token = Devise.token_generator.digest(self, :confirmation_token, confirmation_token)
      self.find_by_confirmation_token(token)
    end
  end
  
end
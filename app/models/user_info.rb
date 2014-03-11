class UserInfo < ActiveRecord::Base
  validate_precense_of :name
end

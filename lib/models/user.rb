class Hancock::User
  include DataMapper::Resource

  property :id, Serial
  property :email,        String, :unique => true, :unique_index => true
  property :access_token, String
  property :enabled,      Boolean, :default => false
  property :password,     Boolean, :default => false

#  validates_with_block :current_password do
#    if current_password and !authenticated?(current_password) and !new_record?
#      [false, "Your current password is incorrect"]
#    else
#      true
#    end
#  end
#
  def reset_access_token
    self.access_token = Digest::SHA1.hexdigest(Time.now.to_s)
    save
  end
#
  def change_password(cur_password, new_password, new_password_confirmation)
    self.current_password = cur_password
    return unless valid?
    update_attributes(:password => new_password, :password_confirmation => new_password_confirmation)
    self.current_password = nil
  end
#
#  def self.signup(contact_info)
#    user = new(contact_info)
#    user.access_token = Digest::SHA1.hexdigest(Time.now.to_s)
#    user.create_contact
#    user.save
#    user
#  end
end

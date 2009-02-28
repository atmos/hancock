class Hancock::User
  include DataMapper::Resource

  property :id,               Serial
  property :first_name,       String
  property :last_name,        String
  property :email,            String, :unique => true, :unique_index => true

  property :salt,             String, :nullable => false
  property :crypted_password, String, :nullable => false

  property :enabled,          Boolean, :default => false
  property :access_token,     String

  attr_accessor :password, :password_confirmation

  def reset_access_token
    self.access_token = Digest::SHA1.hexdigest(Time.now.to_s)
    save
  end

  def change_password(cur_password, new_password, new_password_confirmation)
    self.current_password = cur_password
    return unless valid?
    update_attributes(:password => new_password, :password_confirmation => new_password_confirmation)
    self.current_password = nil
  end
end

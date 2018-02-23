class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  # PWD_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/
  validates :name, presence: true,length: { minimum: 2 }
  validates  :email, presence: true, uniqueness: { case_sensitive: true }, format: { with: EMAIL_REGEX }
  # validates :password, presence: true
  validates_presence_of :password, on: [:create]
  
  before_save :downcase_email
  
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  private
  def downcase_email
    self.email.downcase!
  end

end

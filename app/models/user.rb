class User < ActiveRecord::Base
  extend Displayable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, 
  :validatable, :authentication_keys => [:login]

  has_many :flyers
  has_and_belongs_to_many :plans, join_table: :plans_users

  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  def login=(login)
    @login = login
  end

  def email=(email)
    self[:email] = email.downcase
  end

  def username=(username)
    username.downcase
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR email = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.display_columns
    temp_display_columns.delete_if do
      |v| 
      ['id', 'created_at', 'updated_at', 'encrypted_password', 
      'reset_password_token', 'reset_password_sent_at', 'remember_created_at',
      'sign_in_count', 'current_sign_in_at', 'last_sign_in_at', 'current_sign_in_ip',
      'last_sign_in_ip'
      ].include?(v.to_s) 
    end     
  end

  def self.display_column_index
    h = Hash[column_names.map.with_index.to_a]
    h.except! display_columns
  end

end

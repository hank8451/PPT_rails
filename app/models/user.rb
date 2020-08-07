class User < ApplicationRecord
  # require 'digest'

  validates :account, :email, presence: true, uniqueness: true

  before_create :encrypt_password

  has_many :board_masters

  has_many :boards, through: :board_masters

  def self.login(options)
    if options[:account] && options[:password]
      options[:password] = "x" + options[:password] + "y"
      find_by(account: options[:account], password: Digest::SHA1.hexdigest(options[:password]))
    end
  end

  private

  def encrypt_password
    self.password = bigbang(self.password)
  end

  def bigbang(string)
    string = "x" + string + "y"
    Digest::SHA1.hexdigest(string)
  end
end

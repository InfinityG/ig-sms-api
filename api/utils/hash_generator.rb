require 'securerandom'
require 'digest'
require 'hashids'
require 'base64'

class HashGenerator

  def generate_password_hash(password, salt)
    salted_password = password + salt
    generate_hash salted_password
  end

  def generate_hash(data)
    Digest::SHA2.base64digest data
  end

  def generate_salt
    generate_uuid
  end

  def generate_uuid
    SecureRandom.uuid
  end

  def generate_random_number
    SecureRandom.random_number 1000000
  end

  # this uses a reversible short hash - https://github.com/peterhellberg/hashids.rb
  def generate_short_hash(number)
    hashids = Hashids.new('mysecretsalt')
    hashids.encode(number)
  end
end
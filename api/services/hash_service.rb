require './api/utils/hash_generator'

class HashService
  def initialize(hash_generator = HashGenerator)
    @hash_generator = hash_generator.new
  end

  def generate_short_hash
    num = @hash_generator.generate_random_number
    @hash_generator.generate_short_hash num
  end
end
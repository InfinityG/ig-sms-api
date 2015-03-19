require './api/utils/hash_generator'

class HashService
  def initialize(hash_generator = HashGenerator)
    @hash_generator = hash_generator.new
  end

  def generate_short_hash
    @hash_generator.generate_random_number_by_length 4
    # @hash_generator.generate_short_hash num
  end
end
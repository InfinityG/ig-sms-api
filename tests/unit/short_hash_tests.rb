require 'minitest'
require 'minitest/autorun'
require 'base64'

require_relative '../../api/utils/hash_generator'

class ShortHashTests < MiniTest::Test

  def test_can_generate_short_hash

    generator = HashGenerator.new
    uuid = generator.generate_random_number
    short_hash = generator.generate_short_hash uuid

    puts "Hash: #{short_hash}"

    assert short_hash != nil
  end

  def test_short_hash_embedded_in_message
    message = 'Reply %{SHORT_HASH} to 0822233445'
    generator = HashGenerator.new
    uuid = generator.generate_random_number
    short_hash = generator.generate_short_hash uuid

    puts message % {SHORT_HASH:short_hash}

    end

  def test_no_short_hash_in_message
    message = 'This is a test with no reply'
    generator = HashGenerator.new
    uuid = generator.generate_random_number
    short_hash = generator.generate_short_hash uuid

    puts message % {SHORT_HASH:short_hash}

  end
end
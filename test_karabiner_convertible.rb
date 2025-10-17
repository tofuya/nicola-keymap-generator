require 'minitest/autorun'
require_relative 'karabiner_convertible'

class KarabinerConvertibleExpectedTest < Minitest::Test
  include KarabinerConvertible

  EXPECTED_MANIPULATORS = [
    # 左親指キー
    { type: :basic,
      from: { key_code: 'non_conversion', modifiers: { optional: [:any] } },
      to: [{ set_variable: { name: :left_thumb_active, value: 1 } }],
      to_after_key_up: [{ set_variable: { name: :left_thumb_active, value: 0 } }],
      to_if_alone: [{ key_code: 'non_conversion' }],
      conditions: [JAPANESE_CONDITION] },
    # 通常キー
    { type: :basic,
      from: { key_code: '1', modifiers: { optional: [:caps_lock] } },
      to: [{ key_code: '1' }],
      conditions: [JAPANESE_CONDITION,
                   { type: :variable_unless, name: :left_thumb_active, value: 1 },
                   { type: :variable_unless, name: :right_thumb_active, value: 1 }] }
  ].freeze

  def setup
    @test_table = { '1' => { key: '1', output: { without_thumb: '1',
                                                 with_left_thumb: '!' } } }
    @left_thumb = 'non_conversion'
    @right_thumb = 'conversion'
    @result = format_for_karabiner(title: 'Test Nicola',
                                   description: 'Test mapping',
                                   key_mapping_table: @test_table,
                                   left_thumb: @left_thumb,
                                   right_thumb: @right_thumb)
    @manipulators = @result[:rules].first[:manipulators]
  end

  def deep_match?(actual, expected)
    case expected
    when Hash
      expected.all? do |k, v|
        actual.key?(k) && deep_match?(actual[k], v)
      end
    when Array
      expected.all? do |ev|
        actual.any? { |av| deep_match?(av, ev) }
      end
    else
      actual == expected
    end
  end

  def test_expected_manipulators_exist
    EXPECTED_MANIPULATORS.each do |expected|
      assert @manipulators.any? { |m| deep_match?(m, expected) }, "Expected manipulator not found: #{expected}"
    end
  end
end

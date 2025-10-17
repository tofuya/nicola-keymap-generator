# frozen_string_literal: true

module KarabinerConvertible
  JAPANESE_CONDITION = { type: :input_source_if,
                         input_sources: [
                           { input_mode_id: 'com.apple.inputmethod.Japanese' },
                           { input_mode_id: 'com.apple.inputmethod.Japanese.Hiragana' },
                           { input_mode_id: 'com.apple.inputmethod.Japanese.Katakana' },
                           { input_mode_id: 'com.apple.inputmethod.Japanese.HalfWidthKana' }
                         ] }.freeze

  CHAR_TO_KEY_PAIRS_JIS = [
    { char: '１', key_code: '1' },
    { char: '２', key_code: '2' },
    { char: '３', key_code: '3' },
    { char: '４', key_code: '4' },
    { char: '５', key_code: '5' },
    { char: '６', key_code: '6' },
    { char: '７', key_code: '7' },
    { char: '８', key_code: '8' },
    { char: '９', key_code: '9' },
    { char: '０', key_code: '0' },
    { char: '!', key_code: '1', modifiers: [:left_shift] },
    { char: '?', key_code: :slash, modifiers: [:left_shift] },
    { char: '？', key_code: :slash, modifiers: [:left_shift] },
    { char: '/', key_code: :slash },
    { char: '／', key_code: :slash, modifiers: [:right_option] },
    { char: '。', key_code: :period },
    { char: '.', key_code: :period },
    { char: '．', key_code: :period, modifiers: [:left_option] },
    { char: '、', key_code: :comma },
    { char: ',', key_code: :comma },
    { char: '，', key_code: :comma, modifiers: [:left_option] },
    { char: '：', key_code: :quote },
    { char: ':', key_code: :quote },
    { char: '；', key_code: :semicolon },
    { char: ';', key_code: :semicolon },
    { char: '「', key_code: :close_bracket },
    { char: '」', key_code: :backslash },
    { char: '[', key_code: :close_bracket },
    { char: '［', key_code: :close_bracket, modifiers: [:left_option] },
    { char: ']', key_code: :open_bracket },
    { char: '］', key_code: :backslash, modifiers: [:left_option] },
    { char: '(', key_code: '8', modifiers: [:left_shift] },
    { char: '（', key_code: '8', modifiers: [:left_shift] },
    { char: ')', key_code: '9', modifiers: [:left_shift] },
    { char: '）', key_code: '9', modifiers: [:left_shift] },
    { char: '"', key_code: '2', modifiers: [:left_shift] },
    { char: "'", key_code: '2', modifiers: [:left_shift] },
    { char: '"', key_code: '2', modifiers: [:left_shift] },
    { char: '"', key_code: '2', modifiers: [:left_shift] },
    { char: 'ー', key_code: :hyphen },
    { char: '-', key_code: :hyphen },
    { char: '＿', key_code: :international1 },
    { char: '_', key_code: :international1 },
    { char: '＾', key_code: :equal_sign },
    { char: '^', key_code: :equal_sign },
    { char: '=', key_code: :hyphen, modifiers: [:left_shift] },
    { char: '＝', key_code: :hyphen, modifiers: [:left_shift] },
    { char: '+', key_code: :semicolon, modifiers: [:left_shift] },
    { char: '＋', key_code: :semicolon, modifiers: [:left_shift] },
    { char: '\\', key_code: :international3, modifiers: [:left_option] },
    { char: '\＼', key_code: :international3, modifiers: [:left_option] },
    { char: '¥', key_code: :international3 },
    { char: '￥', key_code: :international3 },
    { char: '<', key_code: :comma, modifiers: [:left_shift] },
    { char: '＜', key_code: :comma, modifiers: [:left_shift] },
    { char: '>', key_code: :period, modifiers: [:left_shift] },
    { char: '＞', key_code: :period, modifiers: [:left_shift] },
    { char: '~', key_code: :equal_sign, modifiers: [:left_shift] },
    { char: '〜', key_code: :equal_sign, modifiers: [:left_shift] },
    { char: '`', key_code: :open_bracket, modifiers: [:left_shift] },
    { char: '｀', key_code: :open_bracket, modifiers: [:left_shift] },
    { char: '・', key_code: :slash },
    { char: '@', key_code: :open_bracket }
  ].to_h { [it[:char], it] }.freeze

  ALLOWED_OPTIONAL_MODIFIERS = [:caps_lock].freeze

  def format_for_karabiner(title:, description:, key_mapping_table:, left_thumb:, right_thumb:)
    { title:, rules: [{ description:,
                        manipulators: generate_manipulators(key_mapping_table, left_thumb, right_thumb) }] }
  end

  def merge_spec(base_spec:, with:)
    base_spec.transform_values do |entry|
      patch = with[entry[:key]]
      next entry unless patch

      merged_output = entry[:output].merge(patch[:output])
      entry.merge(output: merged_output)
    end
  end

  private

  def generate_manipulators(key_mapping_table, left_thumb, right_thumb)
    manipulators = []
    manipulators.concat(thumb_manipulators(left_thumb, right_thumb))

    key_mapping_table.each_value do |row|
      key = row[:key]
      row[:output].each do |pos, seq|
        manipulators << { type: :basic,
                          from: build_from_key(key),
                          to: convert_sequence_to_events(seq),
                          conditions: build_conditions_for_position(pos) }
      end
    end
    manipulators
  end

  def thumb_manipulators(left_key, right_key)
    { left_key => :left_thumb_active,
      right_key => :right_thumb_active }.map do |key, var|
      { type: :basic,
        from: { key_code: normalize_source_key(key), modifiers: { optional: [:any] } },
        to: [{ set_variable: { name: var, value: 1 } }],
        to_after_key_up: [{ set_variable: { name: var, value: 0 } }],
        to_if_alone: [{ key_code: normalize_source_key(key) }],
        conditions: [JAPANESE_CONDITION] }
    end
  end

  def build_from_key(key)
    { key_code: normalize_source_key(key),
      modifiers: { optional: ALLOWED_OPTIONAL_MODIFIERS } }
  end

  def convert_sequence_to_events(seq)
    return [{ key_code: 'vk_none' }] if seq.nil? || seq.to_s.strip.empty?

    seq.each_char.map do |char|
      if mapping = CHAR_TO_KEY_PAIRS_JIS[char]
        { key_code: mapping[:key_code], modifiers: mapping[:modifiers] }.compact
      elsif char =~ /[a-z0-9]/i
        { key_code: char }
      else
        warn "⚠️ 未定義文字: #{char.inspect} → CHAR_TO_KEY_PAIRS_JISに追加してください。"
        { key_code: 'vk_none' }
      end
    end
  end

  def build_conditions_for_position(pos)
    case pos
    when :without_thumb
      [JAPANESE_CONDITION,
       { type: :variable_unless, name: :left_thumb_active, value: 1 },
       { type: :variable_unless, name: :right_thumb_active, value: 1 }]
    when :with_left_thumb
      [JAPANESE_CONDITION,
       { type: :variable_if, name: :left_thumb_active, value: 1 },
       { type: :variable_unless, name: :right_thumb_active, value: 1 }]
    when :with_right_thumb
      [JAPANESE_CONDITION,
       { type: :variable_if, name: :right_thumb_active, value: 1 }]
    else
      [JAPANESE_CONDITION]
    end
  end

  def normalize_source_key(token)
    token_str = token.to_s
    CHAR_TO_KEY_PAIRS_JIS[token_str]&.dig(:key_code)&.to_s || token_str
  end
end

require 'json'
require 'fileutils'
require_relative 'karabiner_convertible'
require_relative 'specs/type_j'
require_relative 'specs/custom'

module Runner
  extend KarabinerConvertible

  OUTPUT_DIR = 'rules'
  RULES_TO_GENERATE = [
    { file_name: 'type_j_spec.json',
      data: format_for_karabiner(title: 'NICOLA Type J (Pure Spec)',
                                 description: 'Pure NICOLA Type J specification for JIS keyboard',
                                 key_mapping_table: TYPE_J_SPEC,
                                 left_thumb: TYPE_J_THUMB_CONFIG[:left],
                                 right_thumb: TYPE_J_THUMB_CONFIG[:right]) },
    { file_name: 'custom.json',
      data: format_for_karabiner(title: 'NICOLA Custom',
                                 description: 'Custom NICOLA configuration based on Type J',
                                 key_mapping_table: merge_spec(base_spec: TYPE_J_SPEC, with: CUSTOM_SPEC),
                                 left_thumb: CUSTOM_THUMB_CONFIG[:left],
                                 right_thumb: CUSTOM_THUMB_CONFIG[:right]) }
  ]

  def self.export_all
    RULES_TO_GENERATE.each do |rule|
      export_rule(rule[:file_name], rule[:data])
    end
    puts "\nDone! Custom overrides: #{CUSTOM_SPEC.size}"
  end

  def self.export_rule(file_name, data)
    path = File.join(OUTPUT_DIR, file_name)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, JSON.pretty_generate(data))

    puts "✓ Generated #{path} (#{data[:rules].first[:manipulators].size} manipulators)"
  end
end

Runner.export_all

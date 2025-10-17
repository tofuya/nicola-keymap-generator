# ============================================================
# NICOLA Type J 純粋仕様定義
# ============================================================

TYPE_J_THUMB_CONFIG = {
  left: 'non_conversion', # 無変換
  right: 'conversion'     # 変換
}.freeze

TYPE_J_SPEC = [
  { key: '1', output: { without_thumb: '１', with_left_thumb: nil, with_right_thumb: '?' } },
  { key: '2', output: { without_thumb: '２', with_left_thumb: nil, with_right_thumb: '／' } },
  { key: '3', output: { without_thumb: '３', with_left_thumb: nil, with_right_thumb: '／' } },
  { key: '4', output: { without_thumb: '４', with_left_thumb: nil, with_right_thumb: '「' } },
  { key: '5', output: { without_thumb: '５', with_left_thumb: nil, with_right_thumb: '」' } },
  { key: '6', output: { without_thumb: '６', with_left_thumb: '［', with_right_thumb: nil } },
  { key: '7', output: { without_thumb: '７', with_left_thumb: '］', with_right_thumb: nil } },
  { key: '8', output: { without_thumb: '８', with_left_thumb: '（', with_right_thumb: nil } },
  { key: '9', output: { without_thumb: '９', with_left_thumb: '）', with_right_thumb: nil } },
  { key: '0', output: { without_thumb: '０', with_left_thumb: nil, with_right_thumb: nil } },
  { key: 'q', output: { without_thumb: '。', with_left_thumb: nil, with_right_thumb: 'xa' } },
  { key: 'w', output: { without_thumb: 'ka', with_left_thumb: 'e', with_right_thumb: 'ga' } },
  { key: 'e', output: { without_thumb: 'ta', with_left_thumb: 'ri', with_right_thumb: 'da' } },
  { key: 'r', output: { without_thumb: 'ko', with_left_thumb: 'xya', with_right_thumb: 'go' } },
  { key: 't', output: { without_thumb: 'sa', with_left_thumb: 're', with_right_thumb: 'za' } },
  { key: 'y', output: { without_thumb: 'ra', with_left_thumb: 'pa', with_right_thumb: 'yo' } },
  { key: 'u', output: { without_thumb: 'ti', with_left_thumb: 'di', with_right_thumb: 'ni' } },
  { key: 'i', output: { without_thumb: 'ku', with_left_thumb: 'gu', with_right_thumb: 'ru' } },
  { key: 'o', output: { without_thumb: 'tu', with_left_thumb: 'du', with_right_thumb: 'ma' } },
  { key: 'p', output: { without_thumb: '，', with_left_thumb: 'pi', with_right_thumb: 'xe' } },
  { key: '@', output: { without_thumb: '、', with_left_thumb: nil, with_right_thumb: nil } },
  { key: 'a', output: { without_thumb: 'u', with_left_thumb: nil, with_right_thumb: 'wo' } },
  { key: 's', output: { without_thumb: 'si', with_left_thumb: 'a', with_right_thumb: 'ji' } },
  { key: 'd', output: { without_thumb: 'te', with_left_thumb: 'na', with_right_thumb: 'de' } },
  { key: 'f', output: { without_thumb: 'ke', with_left_thumb: 'xyu', with_right_thumb: 'ge' } },
  { key: 'g', output: { without_thumb: 'se', with_left_thumb: 'mo', with_right_thumb: 'ze' } },
  { key: 'h', output: { without_thumb: 'ha', with_left_thumb: 'ba', with_right_thumb: 'mi' } },
  { key: 'j', output: { without_thumb: 'to', with_left_thumb: 'do', with_right_thumb: 'o' } },
  { key: 'k', output: { without_thumb: 'ki', with_left_thumb: 'gi', with_right_thumb: 'no' } },
  { key: 'l', output: { without_thumb: 'i', with_left_thumb: 'po', with_right_thumb: 'xyo' } },
  { key: ';', output: { without_thumb: 'nn', with_left_thumb: nil, with_right_thumb: 'xtu' } },
  { key: ':', output: { without_thumb: nil, with_left_thumb: nil, with_right_thumb: nil } },
  { key: ']', output: { without_thumb: nil, with_left_thumb: nil, with_right_thumb: nil } },
  { key: 'z', output: { without_thumb: '．', with_left_thumb: 'xu', with_right_thumb: nil } },
  { key: 'x', output: { without_thumb: 'hi', with_left_thumb: 'ー', with_right_thumb: 'bi' } },
  { key: 'c', output: { without_thumb: 'su', with_left_thumb: 'ro', with_right_thumb: 'zu' } },
  { key: 'v', output: { without_thumb: 'fu', with_left_thumb: 'ya', with_right_thumb: 'bu' } },
  { key: 'b', output: { without_thumb: 'he', with_left_thumb: 'xi', with_right_thumb: 'be' } },
  { key: 'n', output: { without_thumb: 'me', with_left_thumb: 'pu', with_right_thumb: 'nu' } },
  { key: 'm', output: { without_thumb: 'so', with_left_thumb: 'zo', with_right_thumb: 'yu' } },
  { key: ',', output: { without_thumb: 'ne', with_left_thumb: 'pe', with_right_thumb: 'mu' } },
  { key: '.', output: { without_thumb: 'ho', with_left_thumb: 'bo', with_right_thumb: 'wa' } },
  { key: '/', output: { without_thumb: '・', with_left_thumb: nil, with_right_thumb: 'xo' } },
  { key: '_', output: { without_thumb: '＿', with_left_thumb: nil, with_right_thumb: nil } }
].to_h { [it[:key], it] }.freeze

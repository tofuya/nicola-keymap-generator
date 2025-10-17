# ============================================================
# カスタム設定
# ============================================================
# Type J をベースに、自分用にカスタマイズする部分だけを記述

CUSTOM_THUMB_CONFIG = {
  left: 'lang2', # 英数キー
  right: 'spacebar'
}.freeze

CUSTOM_SPEC = [
  { key: '1', output: { with_right_thumb: '!' } },
  { key: '/', output: { without_thumb: '・', with_left_thumb: 'xo', with_right_thumb: '?' } }
].to_h { |m| [m[:key], m] }.freeze

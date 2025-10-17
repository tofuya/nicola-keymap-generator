# NICOLA Karabiner ジェネレータ

親指シフト（NICOLA）配列を Mac の JIS キーボード向けに
Karabiner-Elements 用の JSON ルールを生成するスクリプト。

---

## 定数

- **`JAPANESE_CONDITION`**  
  日本語入力モードの定義。

- **`CHAR_TO_KEY_PAIRS_JIS`**  
  文字と `key_code`／`modifiers` の対応表。  
  Karabiner に直接渡せる形へ正規化するために使用。  
  未定義文字は `vk_none` にフォールバック。

- **`TYPE_J_THUMB_CONFIG`**  
  Type J の標準親指キー設定。  
  例：`left: :non_conversion`, `right: :conversion`

- **`CUSTOM_THUMB_CONFIG`**  
  カスタム親指キー設定。`TYPE_J_THUMB_CONFIG` をベースにこの値で上書きする。

- **`TYPE_J_SPEC`**  
  純正 NICOLA 配列（Type J）のベース仕様。

- **`CUSTOM_SPEC`**  
  `TYPE_J_SPEC` を上書き・変更するカスタム用の配列。

---

## 使い方

```bash
ruby generate.rb
```

- `rules/` ディレクトリ以下に JSON ファイルが生成される。  
  例：`rules/custom.json`, `rules/type_j_spec.json`

---

## 注意

- **日本語モードでも半角数字を出力したい場合は、IME の設定で制御する必要がある。**  
  例：Mac の「システム設定」→「キーボード」→「入力ソース」→「日本語 - ローマ字入力」→「半角/全角の数字」などで「半角」を選択。

- Ruby 3.3 以降で動作確認済み。

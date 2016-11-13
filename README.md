# patet_f.vim

## 概要

vimのf, F移動を拡張したプラグインです。vimにf移動用のモードを追加することで連続して異なる文字へカーソル移動することができます（当然、`;`を使用せずに同じ文字へも移動可能です）。
また、dfやyfといったオペレータ待機モードでの利用時は対象の文字列がわかるようvisualモードと同様、選択中で表示します。

## 環境とインストール
### Version
vim 7.4
※これより前のバージョンでは動作未確認

### インストール
ソースは[ここ](https://github.com/sfuta/patet_f.vim)
dein.vimを使用する場合は以下を設定ファイル(`.vimrc`等)に追加

```
call dein#add('sfuta/patet_f.vim')
```

## 動作

このプラグインで以下のモードが追加される

* f MOVE
* F MOVE
* f MOVE VISUAL
* F MOVE VISUAL
* df MOVE
* dF MOVE
* yf MOVE
* yF MOVE
* cf MOVE
* cF MOVE


### 各モードの共通動作

| キー | 動作概要 |
|:--|:--|
|文字キー|打鍵したキー文字位置へ移動|
|Enter|決定キー（モードを抜ける)|
|Esc|キャンセルキー（モードを抜ける)|
|Ctrl-f|方向切替(fとFの切替)|

※「文字キー」以外は設定変更可

### f MOVE, F MOVE
いわゆるノーマルモードでのf, F移動の拡張。fでf MOVEモード、FでF MOVEモードに切り替わる。
両モードともにEnterキーかEscキーを打つことでモードを抜けることができる

f MOVEモード中は打鍵したキー文字が右位置にあればそこへカーソルが移動する

例えば、こんな文字列のときfunctionのcへ移動したいとき。
f MOVEモードに切り替え後に`cc`とうつ、もしくは`<Space>c`とうってもよい。
※\<Space\>はスペースキー

```
public function getMemberName() ・・・・
```


F MOVEモードはf MOVEモードと逆に打鍵したキー文字が左位置にあればそこへカーソルが移動する

Ctrl-fにより、f MOVEモードとF MOVEモードが切り替わる

### f MOVE VISUAL, F MOVE VISUAL
いわゆるvisualモードでのf, F移動の拡張。操作, 動作に関してはf MOVE, F MOVEと同じ。
違いはvisualモード上で動作するという点のみ

### df MOVE, dF MOVE
いわゆるdによるオペレータ待機モードでのf, F移動、つまりdf, dFと打鍵した場合の拡張。操作/動作に関してはf MOVE, F MOVEとほぼ同じ。

以下点に関し、f MOVE, F MOVEと異なる。

* 表示がvisualモード。（切り取り文字列をわかりやすくするため）
* Enterキー打鍵により、切り取りを実行しモードを抜ける。
* Escキー打鍵により、切り取り未実行でモードを抜ける。

なお、`.`リピートするためには別途、[vim-repeat](https://github.com/tpope/vim-repeat)をインストールする必要がある

### yf MOVE, yF MOVE
いわゆるyによるオペレータ待機モードでのf, F移動、つまりyf, yFと打鍵した場合の拡張。操作／動作に関してはdf MOVE, dF MOVEとほぼ同じ。
切り取りではなくコピー（ヤンク）である点が異なる。
※なお、`.`でリピートはしない（元のyf, yF同様）

### cf MOVE, cF MOVE
いわゆるcによるオペレータ待機モードでのf, F移動、つまりcf, cFと打鍵した場合の拡張※。操作／動作に関してはdf MOVE, dF MOVEとほぼ同じ。
Enterキー打鍵により、INSERTモードとなる点が異なる

なお、dの場合同様、`.`リピートは別途、[vim-repeat](https://github.com/tpope/vim-repeat)をインストールする必要がある

※`u`によるUndo時の動きは元のcfと動作が異なっている。
元のcfは`u`一回で切り取りした文字列を表示するが、このプラグインのcfでは`u`一回で切り取りした状態。もう一回`u`を打鍵することで切り取り前の文字列を表示する。

### デモ
#### f MOVE, F MOVE, f MOVE VISUAL, F MOVE VISUAL
![patet_f_demo_nv_z.gif](https://raw.githubusercontent.com/sfuta/repo-contents/master/patet_f.vim/demo/patet_f_demo_nv_z.gif)

#### df MOVE, dF MOVE, cf MOVE, cF MOVE, yf MOVE, yF MOVE
![patet_f_demo_dcy_z.gif](https://raw.githubusercontent.com/sfuta/repo-contents/master/patet_f.vim/demo/patet_f_demo_dcy_z.gif)

## 設定

### 各種設定値

|変数名|説明|値|
|:--|:--|:--|
|g:patet_f_enable  |プラグイン利用可否|1:有効,0:無効,既定:1|
|g:patet_f_showmode|モードのステータス表示|1:表示,0:非表示,既定:set showmodeの値|
|g:patet_f_key_switch|方向切替(fとFを切替)キー|既定:\<C-f\>|
|g:patet_f_key_finish|決定キー|既定:\<CR\>|
|g:patet_f_key_escape|キャンセルキー|既定:\<Esc\>|
|g:patet_f_timeout_ms|決定までのタイマー値|既定：0(無効)|
|g:patet_f_no_mappings|デフォルトのマップを無効にする|0(または未定義):マップ有効,1:マップ無効,既定:未定義|

**g:patet_f_timeout_msについて**

モード切替後に1文字打鍵後に何ミリ秒でモードを抜けるか時間を設定するための機能
※元のf, Fと同じ動きもできるようするためにつけた機能

例えば、fxと打鍵した場合、
`g:patet_f_timeout_ms=100`と設定時は100ミリ秒の間に文字キーを打鍵しなければ、モードを自動で抜ける（時間経過で決定キーを打鍵した場合と同様の動作となる）
0設定時はタイマーが無効となり、決定キー/キャンセルキーを打鍵するまでモードは継続し続ける
※`g:patet_f_timeout_ms`の利用には`+reltime`が必要

### シンタックスハイライト

|ハイライトグループ名|説明|
|:-- |:-- |
|PatetFCursor|モード中のカーソルの色と表示形式|
|PatetFCursorLine|モード中の行の色と表示形式|

### マッピング

|マップ名|処理|対象のモード|既定値|
|:-- |:-- |:-- |:-- |
|\<Plug\>patet_f_forward_n|f MOVEへの切替|ノーマルモード|f|
|\<Plug\>patet_f_back_n|F MOVEへの切替|ノーマルモード|F|
|\<Plug\>patet_f_forward_x|f MOVE VISUALへの切替|Visualモード|f|
|\<Plug\>patet_f_back_x|F MOVE VISUALへの切替|Visualモード|F|
|\<Plug\>patet_f_forward_o|df MOVE,yf MOVE,cf MOVEへの切替|オペレータ待機モード|f|
|\<Plug\>patet_f_back_o|dF MOVE,yF MOVE,cF MOVEへの切替|オペレータ待機モード|F|

例えば、

```
nmap t <Plug>patet_f_forward_n
```
とすることで、tでf MOVEモードへ切替ができるようになる

## ライセンス
[MITライセンス](https://github.com/sfuta/patet_f.vim/blob/master/doc/MIT-LICENSE)

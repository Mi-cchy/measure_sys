load(openpose_map.mat)
load(poses.mat)

%{
そのフレームに関節位置があるか調べる

以下認識した関節がある時
・画像取り込んでサイズを調べる
・位置を比率で出す(0-1?)
・点群のminmaxから比率を求める
・点群の範囲を指定
・中央値からデプスをとる
（回転させ平面をz=0にあわせる）
・3次元関節位置データとしてmatファイルに保存
%}
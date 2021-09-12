# measure_sys

## 処理の流れ
1. iPadにより計測したplyファイルのディレクトリを指定
2. make_XYpic.m により点群のXY平面への投影図をpng形式で保存
3. cv2_trim.py で画像の端と点群の最も外側の点が一致するようにトリミング
4. OpenPoseにより関節位置を含むjsonファイルを作成
5. json2mat.py により.mat形式にデータを変換
6. depth_calc.m でOpenPoseで出力した点のZ座標を求める

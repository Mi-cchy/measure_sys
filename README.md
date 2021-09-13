# measure_sys

## 処理の流れ
1. iPadにより計測したplyファイルのディレクトリを指定
2. make_XYpic.m により点群のXY平面への投影図をpng形式で保存
 MATLABのコマンドウィンドウで
 ```
 make_XYpic("D:\\ipad_data\\ply_0911_s_min_3")
 ```
3. cv2_trim.py で画像の端と点群の最も外側の点が一致するようにトリミング
 ```
 $ python .\cv2_trim.py "D:\\ipad_data\\ply_0911_s_min_3"
 ```
4. OpenPoseにより関節位置を含むjsonファイルを作成
 ```
 $ cd c:\tools\openpose
 $ bin\OpenPoseDemo.exe --image_dir "C:\Users\mitsuhiro\Documents\measure_sys\trimmed_images\ply_0911_s_min_3" --net_resolution "320x240" --write_json "C:\Users\mitsuhiro\Documents\measure_sys\json\ply_0911_s_min_3" --write_images "C:\Users\mitsuhiro\Documents\measure_sys\result_render\ply_0911_s_min_3"
 ```
5. json2mat.py により.mat形式にデータを変換
 ```
 $ cd C:\Users\mitsuhiro\Documents\measure_sys
 ```
 ```
 python .\json2mat.py "C:\Users\mitsuhiro\Documents\measure_sys\json\ply_0911_s_min_3"
 ```
6. depth_calc.m でOpenPoseで出力した点のZ座標を求める
 MATLABのコマンドウィンドウで
 ```
 depth_calc("D:\\ipad_data\\ply_0911_s_min_3", "0911_s_min_3")
 ```
 ※出力のmatファイル名も指定("3Dposes_<2個目の引数>.mat")

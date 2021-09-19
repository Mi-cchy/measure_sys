clear;
% ディレクトリを指定
PLY_file_dir = "D:\ipad_data\2021-09-18--12-18-31\PLY"
save_name = "inoue_s_70"
% name_direction_height  f:front b:back s:side height:40
SIDE = true % 矢状面測定のときはtrue

%% pngファイルの作成
make_XYpic(PLY_file_dir, SIDE)

%% pngのトリミング
cmd = append('python .\cv2_trim.py ', '"', PLY_file_dir,'" "', save_name, '"')
status = system(cmd)

%% OpenPoseの実行
oldFolder = cd("c:\tools\openpose")
% bin\OpenPoseDemo.exe --image_dir "C:\Users\mitsuhiro\Documents\measure_sys\trimmed_images" --net_resolution "320x240" --write_json "C:\Users\mitsuhiro\Documents\measure_sys\json0911" --write_images "C:\Users\mitsuhiro\Documents\measure_sys\result_render"

% 要修正
img_dir = "C:\Users\mitsuhiro\Documents\measure_sys\trimmed_images\" + save_name;
output_img_dir = "C:\Users\mitsuhiro\Documents\measure_sys\result_render\" + save_name;
output_json_dir = "C:\Users\mitsuhiro\Documents\measure_sys\json\" + save_name;
cmd = append('bin\OpenPoseDemo.exe --image_dir "', img_dir, '" --net_resolution "320x240" --write_json "', output_json_dir, '" --write_images "', output_img_dir, '"')
status = system(cmd)

cd(oldFolder)
%% jsonのパース
cmd = append('python .\json2mat.py ',  '"', output_json_dir, '" "', save_name, '"')
status = system(cmd)

%% 深度の取得
depth_calc(PLY_file_dir, save_name, SIDE)

%% アニメーションの作成
plot3D(save_name, SIDE)
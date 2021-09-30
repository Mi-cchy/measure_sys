% 点群表示するだけのコード

ptCloud = pcread("D:\ipad_data\0924_calib\ply2\0001000.ply")
ptCloud = pcdenoise(ptCloud)
pcshow(ptCloud)
view(0,90)
% campos([-1.0, 2, 3])
% camup([0 1 0])
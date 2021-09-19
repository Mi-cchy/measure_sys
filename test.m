load('openpose_map.mat')
load('poses_inoue_s_70.mat')
load('imgsize.mat')

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

oldFolder = cd("D:\ipad_data\2021-09-18--12-18-31\PLY");
i = 301
side = 1
ply_list = dir('*.ply');
ptCloud = pcread(ply_list(i).name)
ptCloud = pcdenoise(ptCloud);
ptCloudSize = [ptCloud.XLimits ptCloud.YLimits ptCloud.ZLimits];
Xlength = ptCloudSize(2)-ptCloudSize(1);
Ylength = ptCloudSize(4)-ptCloudSize(3);

for j = 1:25
    j
    if  poses{1, i}.openpose_keypoints(j,1) ~= 0
        x = poses{1, i}.openpose_keypoints(j,1);
        y = poses{1, i}.openpose_keypoints(j,2);

        if side == 0
            X = ptCloudSize(1) + x/double(imgsize(i,2))*Xlength;
            Y = ptCloudSize(4) - y/double(imgsize(i,1))*Ylength;
        else
            X = ptCloudSize(2) - y/double(imgsize(i,1))*Xlength
            Y = ptCloudSize(4) - x/double(imgsize(i,2))*Ylength
        end



        roi = [ X-0.01 X+0.01 Y-0.01 Y+0.01 -4 0 ];
        indices = findPointsInROI(ptCloud,roi);
        if j == 1
            ptCloudB = select(ptCloud,indices)
        else
            ptCloudC = select(ptCloud,indices);
            ptCloudB = pccat([ptCloudB,ptCloudC])
        end
    end 
end



% RKnee = poses{1, 344}.openpose_keypoints(14,:)
% x = RKnee(1)
% y = RKnee(2)
% 
% X = ptCloudSize(1) + x/double(imgsize(344,2))*Xlength
% Y = ptCloudSize(4) - y/double(imgsize(344,1))*Ylength
% 
% roi = [ X-0.01 X+0.01 Y-0.01 Y+0.01 -4 0 ];
% indices = findPointsInROI(ptCloud,roi);
% ptCloudB = select(ptCloud,indices)
% median(ptCloudB.Location(:,3))

clf
figure
% pcshow(ptCloud.Location,[0.5 0.5 0.5])
pcshow(ptCloud)
hold on
pcshow(ptCloudB.Location,'r');
legend('Point Cloud','Points within ROI','Location','southoutside','Color',[1 1 1])
hold off
% view(0,90)
% 矢状面測定時
view(-90,90)
cd(oldFolder) 

    
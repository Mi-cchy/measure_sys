load('openpose_map.mat')
load('poses.mat')
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

oldFolder = cd("D:\ipad_data\ply_0911");

ptCloud = pcread('0000343.ply')
ptCloud = pcdenoise(ptCloud)
ptCloudSize = [ptCloud.XLimits ptCloud.YLimits ptCloud.ZLimits];
Xlength = ptCloudSize(2)-ptCloudSize(1);
Ylength = ptCloudSize(4)-ptCloudSize(3);
for i = 1:25
    i
    x = poses{1, 344}.openpose_keypoints(i,1);
    y = poses{1, 344}.openpose_keypoints(i,2);

    X = ptCloudSize(1) + x/double(imgsize(344,2))*Xlength;
    Y = ptCloudSize(4) - y/double(imgsize(344,1))*Ylength;

    roi = [ X-0.01 X+0.01 Y-0.01 Y+0.01 -4 0 ];
    indices = findPointsInROI(ptCloud,roi);
    
    if i == 1
        ptCloudB = select(ptCloud,indices)
    else
        ptCloudC = select(ptCloud,indices)
        ptCloudB = pccat([ptCloudB,ptCloudC])
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
view(0,90)

cd(oldFolder) 

    
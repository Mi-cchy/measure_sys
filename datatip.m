% 参考　https://jp.mathworks.com/help/vision/lidar-and-point-cloud-processing.html?s_tid=CRUX_lftnav

% PLYファイルの読み込み（点群取得）
list = dir('*.ply')
disp(list(1))
ptCloud = pcread('0001000.ply')
% pcloud.PreserveStructureOnRead = true;
% pcdenoise:ノイズの除去　pcshow:点群のグラフ表示
ptCloud = pcdenoise(ptCloud);

ptCloudSize = [ptCloud.XLimits ptCloud.YLimits ptCloud.ZLimits];

tic
roi = [ 0.00 0.01 0.00 0.01 -4 0 ];
indices = findPointsInROI(ptCloud,roi);
ptCloudB = select(ptCloud,indices)
median(ptCloudB.Location(:,3))
toc
% figure
% pcshow(ptCloud.Location,[0.5 0.5 0.5])
% hold on
% pcshow(ptCloudB.Location,'r');
% legend('Point Cloud','Points within ROI','Location','southoutside','Color',[1 1 1])
% hold off
% view(0,90)

median(ptCloudB.Location(:,3))

tic
pcshow(ptCloud);
% 表示方向の設定

% view(0,90)
axis off
view(0,90)
% 画像データとして保存
% saveas(gcf,"img1000.png")
exportgraphics(gcf,"img1000.png")
toc

%{
画像ファイルと.plyファイルの対応を取りたいが迷走中
X,Y座標から点群の中の一点を指定し、その点のZ座標を取得したい
%}
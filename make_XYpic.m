% 参考　https://jp.mathworks.com/help/vision/lidar-and-point-cloud-processing.html?s_tid=CRUX_lftnav

% PLYファイルの読み込み（点群取得）
oldFolder = cd("D:\ipad_data\ply_0911")
mkdir png_datas
list = dir('*.ply')
% disp(list(1))

for i = 1:length(list)
    [filepath,name,ext] = fileparts(list(i).name);
    ptCloud = pcread(list(i).name);
    ptCloud = pcdenoise(ptCloud);
    pcshow(ptCloud);
    % 表示方向の設定
    axis off
    view(0,90)
    % 画像データとして保存
    % saveas(gcf,"img1000.png")
    exportgraphics(gcf,"png_datas\" + name + ".png")
end

cd(oldFolder)
% 参考　https://jp.mathworks.com/help/vision/lidar-and-point-cloud-processing.html?s_tid=CRUX_lftnav

% PLYファイルの読み込み（点群取得）

function make_XYpic(PLY_file_dir) 

    oldFolder = cd(PLY_file_dir)
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
        % 矢状面測定時
        view(-90,90)
%         % 前額面測定時
%         view(0,90)

        % 画像データとして保存
        % saveas(gcf,"img1000.png")
        exportgraphics(gcf,"png_datas\" + name + ".png")
    end

    cd(oldFolder)
    
end
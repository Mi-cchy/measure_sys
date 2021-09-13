function depth_calc(PLY_file_dir, output_name)

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

    oldFolder = cd(PLY_file_dir)
    ply_list = dir('*.ply');

    tic
    for i = 1:length(ply_list)
        i
        if isempty(poses{1, i}.openpose_keypoints) == 0
           % 関節データが含まれるのでplyを読み込む
            ptCloud = pcread(ply_list(i).name);
            ptCloud = pcdenoise(ptCloud);
            ptCloudSize = [ptCloud.XLimits ptCloud.YLimits ptCloud.ZLimits];
            Xlength = ptCloudSize(2)-ptCloudSize(1);
            Ylength = ptCloudSize(4)-ptCloudSize(3);

            for j = 1:25
                if  poses{1, i}.openpose_keypoints(j,1) ~= 0
                    x = poses{1, i}.openpose_keypoints(j,1);
                    y = poses{1, i}.openpose_keypoints(j,2);

                    X = ptCloudSize(1) + x/double(imgsize(i,2))*Xlength;
                    Y = ptCloudSize(4) - y/double(imgsize(i,1))*Ylength;

                    roi = [ X-0.01 X+0.01 Y-0.01 Y+0.01 -4 0 ];
                    indices = findPointsInROI(ptCloud,roi);
                    ptCloudB = select(ptCloud,indices);
                    % 対象領域のzの中央値をその点のz座標とする

                    poses3d(i).joint_position(j,1) = X;
                    poses3d(i).joint_position(j,2) = Y;
                    poses3d(i).joint_position(j,3) = median(ptCloudB.Location(:,3));
               end
           end
        end
    end

    cd(oldFolder)
    out_name = "3Dposes_" + outputname + ".mat";
    save(out_name,'poses3d')
    toc
end
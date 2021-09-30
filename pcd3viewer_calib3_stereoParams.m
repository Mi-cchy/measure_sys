clear
% close all

% load data
load stereoparams_ipad.mat
% load stereoParams_75deg_AC_all.mat
% load stereoParams_90deg_AD_all.mat
rot=stereoParams.RotationOfCamera2;
trans=stereoParams.TranslationOfCamera2/1000;
% trans=[0 0 0];
%変換行列の作成
tform = rigid3d(rot,trans);

%フレーム数
s_num = 1;
e_num = 1;

% rot&trans
cd B\pcd
% pcdFolderInfo = dir('*.pcd');
% data_num = size(pcdFolderInfo,1);

for num=s_num:e_num
    i=num2str(sprintf('%05.0f', num-1));
    filename=strcat(i,'.ply');
%     ptA{1,num} = pcread(filename);
    pt{1,num} = pcread(filename);
    pt{1,num} = pctransform(pt{1,num},tform);
end
% 
% cd ../../2021-03-02.13-34-28.B\pcd
% pcdFolderInfo = dir('*.pcd');
% data_num = size(pcdFolderInfo,1);
% 
% for num=s_num:e_num
%     i=num2str(sprintf('%05.0f', num-1));
%     filename=strcat(i,'.pcd');
% %     ptB{1,num} = pcread(filename);
%     pt{2,num} = pcread(filename);
%     pt{2,num} = pctransform(pt{2,num},Btform);
%     pt{2,num} = pctransform(pt{2,num},Btform2);
% end

cd ../../A\pcd
% cd ../../2021-09-07.17-31-20.C\pcd
% cd ../../2021-09-07.17-31-10.D\pcd
% pcdFolderInfo = dir('*.pcd');
% data_num = size(pcdFolderInfo,1);

for num=s_num:e_num
    i=num2str(sprintf('%06.0f', num-1));
    filename=strcat(i,'.ply');
    pt{3,num} = pcread(filename);
%     pt{3,num} = pctransform(pt{3,num},tform);
end


fig=1;
% for num=1:data_num


figure
grid;
for num=s_num:e_num

    for k=1:2:3
        pcshow(pt{k,num});
        set(gcf,'color','w');
        set(gca,'color','w');
%         view([-90 0]);
%        xlim([-1.0 1.0]);
%         xticks([-1.2 -1.0 -0.5 0 0.5 1.0 1.2]);
        xlabel('x');
%         ylim([-1.0 1.0]); 
%         yticks([-1.0 -0.5 0 0.5 1.0]); 
        ylabel('y');
%         zlim([-1.0 1.0]); 
%         zticks([0 0.5 1.0 1.5 2.0]); 
        zlabel('z');
        %     pause
        hold on
    end
end

hold off


figure
grid;
for num=s_num:e_num

    for k=1:2:3
        pcshow(pt{k,num});
        set(gcf,'color','w');
        set(gca,'color','w');
%         view([-90 0]);
       xlim([-1.0 1.0]);
%         xticks([-1.2 -1.0 -0.5 0 0.5 1.0 1.2]);
        xlabel('x');
%         ylim([-1.0 1.0]); 
%         yticks([-1.0 -0.5 0 0.5 1.0]); 
        ylabel('y');
        zlim([1.0 2.6]); 
%         zticks([0 0.5 1.0 1.5 2.0]); 
        zlabel('z');
        %     pause
        hold on
    end
end

hold off

% Rot
function [rot] = ...
    Rotation(A, B, C)

rot=[cos(B)*cos(C), sin(A)*sin(B)*cos(C)-cos(A)*sin(C), cos(A)*sin(B)*cos(C)+sin(A)*sin(C);...
    cos(B)*sin(C), sin(A)*sin(B)*sin(C)+cos(A)*cos(C), cos(A)*sin(B)*sin(C)-sin(A)*cos(C);...
    -sin(B), sin(A)*cos(B), cos(A)*cos(B)];
end
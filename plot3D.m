function plot3D(save_name, side)
    mat_name = "3Dposes_" + save_name +".mat";
    load(mat_name)

    v = VideoWriter('result_video\'+ save_name + '.avi');
    v.FrameRate = 60;
    open(v)

    for i = 1:size(poses3d,2)
        i

        color = linspace(1,10,25);
        try
            scatter3(poses3d(i).joint_position(:,1), poses3d(i).joint_position(:,2), poses3d(i).joint_position(:,3), 30, color)
%         plot3(poses3d(i).joint_position(:,1), poses3d(i).joint_position(:,2), poses3d(i).joint_position(:,3), 30, color)
        catch
            % 空白のフレームを挟みたい
            continue
        end
        if side == 0
            xlim([-1.5 1.5])
            ylim([-1.0 2.0])
            zlim([-4.5 0.5])
            xlabel('x')
            ylabel('y')
            zlabel('z')
            campos([-1.0, 2, 3])
            camup([0 1 0])
        elseif side == 1
            xlim([-1.0 1.5])
            ylim([-3.0 3.0])
            zlim([-4.5 0.5])
            xlabel('x')
            ylabel('y')
            zlabel('z')
            campos([2.0, 4.0, 0.0])
            camup([1 0 0])
        else 
            xlim([-1.0 1.5])
            ylim([-3.0 3.0])
            zlim([-4.5 0.5])
            xlabel('x')
            ylabel('y')
            zlabel('z')
%             campos([0.0, 3.0, -2.5])
%             camup([1 0 0])   
            view([0 1 0])
        end
            
%         view([0 0]) % [0 0]:xz平面（上から） [0 90]:xy平面（正面から）
        grid on
        drawnow limitrate

        frame = getframe(gcf);
        writeVideo(v, frame)

    end

    close(v)
end
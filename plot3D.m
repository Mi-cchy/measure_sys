load('3Dposes.mat')

for i = 1:630
    i
    try
        color = linspace(1,10,25);
        scatter3(poses3d(i).joint_position(:,1), poses3d(i).joint_position(:,2), poses3d(i).joint_position(:,3), 30, color)
        xlim([-1.5 1.5])
        ylim([-1.0 2.0])
        zlim([-5.0 1.0])
        xlabel('x')
        ylabel('y')
        zlabel('z')
        
        view([0 0]) % [0 0]:xz平面（上から） [0 90]:xy平面（正面から）
        pause(0.02)
    catch
        continue
    end
end
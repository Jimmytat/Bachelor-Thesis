% 定义角度和位移的范围
angle_min = 0;
angle_max = 5;
misalignment_min = 0;
misalignment_max = 4;

% 设置角度和位移的步长
angle_step = 0.1;
misalignment_step = 0.1;

% 预分配矩阵
[angle_values, misalignment_values] = meshgrid(linspace(angle_min, angle_max, 100), ...
                                               linspace(misalignment_min, misalignment_max, 100));

% 给定的模型参数
a =  0.00012999;
b = -0.00002058; 
m = -0.0008;

% 初始化常数项 c
c = 2.9764; % 初始常数项

% 计算 F 的值
F = a * angle_values.^2 +b * angle_values + m * misalignment_values + c;
% 绘制三维图
figure(1);
surf(angle_values, misalignment_values, F);
xlabel('Angle');
ylabel('Misalignment');
zlabel('F');
title('Surface plot of F = 0.00013 * angle^2 - 0.000021*angle - 0.0008 * misalignment + 2.9764');

colorbar; % 显示颜色条
view(157, 11);



% 分别的影响

% 定义角度和位移的范围
angle_range = 0:0.1:5; % 0 到 5，步长为 0.1
misalignment_range = 0:0.1:4; % 0 到 4，步长为 0.1

% 计算 F 的值
F_angle = a * angle_range + c; % 固定 misalignment = 0
F_misalignment = +b * misalignment_range + c; % 固定 angle = 0

% % 创建图形窗口
% figure(2);
% 
% % 绘制 F 随 angle 变化的图像
% subplot(2, 1, 1); % 2行1列的第一个子图
% plot(angle_range, F_angle, 'b-');
% xlabel('Angle');
% ylabel('F');
% title('F vs. Angle (Misalignment = 0)');
% 
% % 绘制 F 随 misalignment 变化的图像
% subplot(2, 1, 2); % 2行1列的第二个子图
% plot(misalignment_range, F_misalignment, 'r-');
% xlabel('Misalignment');
% ylabel('F');
% title('F vs. Misalignment (Angle = 0)');
% 
% % 调整子图之间的间距
% subplot(2, 1, 1);
% axis tight;
% subplot(2, 1, 2);
% axis tight;
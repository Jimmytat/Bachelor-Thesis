% 读取 Excel 文件
data = readtable('Results.xlsx', 'Sheet', 'Sheet3');

% 提取角度数据
angles = data{2:end, 1}; % 这应该是一个 10x1 的向量
% 提取位移数据
displacements = data{1, 2:end}; % 这应该是一个 1x11 的向量
% 提取力的数据
forces = table2array(data(2:end, 2:end)); % 这将是一个 10x11 矩阵

% 使用 Kronecker 积扩展角度和位移，以匹配 forces 矩阵的尺寸
[X, Y] = meshgrid(displacements, angles);
Z = forces;

% 准备插值网格
xi = linspace(min(X(:)), max(X(:)), size(forces, 2));
yi = linspace(min(Y(:)), max(Y(:)), size(forces, 1));
[Xq, Yq] = meshgrid(xi, yi);

% 使用 griddata 进行三维插值
Zq = griddata(X(:), Y(:), Z(:), Xq, Yq, "natural");

% 绘制三维曲面图
figure(1);
surf(Xq, Yq, Zq);

% 设置X轴、Y轴和Z轴的文字大小
xlabel('Misalignment/mm', 'FontSize', 16);
ylabel('Angle/deg', 'FontSize', 16);
zlabel('Force/N', 'FontSize', 16);

% 获取当前坐标轴对象
ax = gca;

% 调整坐标轴标题和刻度标签的文字大小
title('Results force under the influence of misalignment and deflection angle', 'FontSize', 20);
ax.FontSize = 14; % 调整坐标轴刻度标签的文字大小

% 其他属性调整
ax.FontWeight = 'bold'; % 坐标轴文字加粗
ax.FontName = 'Arial'; % 坐标轴文字字体

% 显示颜色条并调整颜色条文字大小
colorbar;
cbar = colorbar;
cbar.FontSize = 16; % 调整颜色条文字大小



% 设置视角
view(157, 11);

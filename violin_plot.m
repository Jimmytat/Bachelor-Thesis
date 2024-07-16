% 假设 stabilization_times 已经加载到工作空间中
load('stabilization_times.mat'); % 加载仿真结果

% 计算99.9%分位数
p999 = prctile(stabilization_times, 99.9);

% 筛选超过99.9%分位数的数据
data_to_plot = stabilization_times(stabilization_times > p999);

% 调用自定义的小提琴图函数
myViolinPlot(data_to_plot);

function myViolinPlot(data)
    % data: 一个包含多个仿真结果时间的向量或矩阵

    % 将 NaN 值删除
    data = data(~isnan(data));

    % 计算95%分位数
    p95 = prctile(data, 95);
    p99 = prctile(data, 99);
    p100 = max(data);

    % 创建小提琴图
    figure;
    violinWidth = 0.5; % 小提琴宽度
    edgeColor = 'k';   % 边缘颜色
    boxColor = [0.5 0.5 0.5]; % 箱线图颜色

    % 计算小提琴图的核密度估计
    h = violin(data, 'ViolinColor', boxColor, 'EdgeColor', edgeColor, 'Width', violinWidth);

    % 设置标题和坐标轴标签
    title('Stabilization Times ', 'FontSize', 18);
    xlabel('Simulations', 'FontSize', 18);
    ylabel('Time (s)', 'FontSize', 18);
    set(gca, 'FontSize', 18); % 设置坐标轴字体大小
    grid on;

    % 添加95%标注线及其数值
    hold on;
    plot([0.5 1.5], [p95 p95], 'r-', 'LineWidth', 2,'LineStyle', '--'); % 在 x 范围内添加水平线
    text(1.1, p95, sprintf('Accuracy: 95%% \nStabilization Time: %.4f s', p95), 'Color', 'red', 'FontSize', 18, 'VerticalAlignment', 'bottom');

    plot([0.5 1.5], [p99 p99], 'blue-', 'LineWidth', 2,'LineStyle', '--'); % 在 x 范围内添加水平线
    text(1.1, p99, sprintf('Accuracy: 99%% \nStabilization Time: %.4f s', p99), 'Color', 'blue', 'FontSize', 18, 'VerticalAlignment', 'bottom');

    % 获取当前坐标轴的上限
    upperYLim = get(gca, 'YLim');
    maxLineY = upperYLim(2); % 取上限作为100%分位数线的位置

    % 画一条横线表示100%分位数
    line([0.5 1.5], [maxLineY maxLineY], 'Color', 'k', 'LineWidth', 2, 'LineStyle', '--');
        text(0.6, 0.288, 'Accuracy: 100% Stabilization Time: 0.2881s', 'Color', 'k', 'FontSize', 18, 'FontName', 'left');

legend('CDF','Mean', 'Median','95%', '99%', '100% Maximum');

end



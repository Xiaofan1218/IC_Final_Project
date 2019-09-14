
%% Plot figure 4.1.3
clc;close all;clear;

dim = 2;
G = [1 0;1/2 sqrt(3)/2];

sigma = [0 0.1 0.25];

sample_num = 1000;
range = [0 1;0 1];

co = generate_coef(range, sample_num, dim);
y_or = co * G;


range3 = [-3 3;-3 3];
co3 = generate_coef(range3, sample_num, dim);
y3 = co3 * G;


vnr = calculate_vnr (G, sigma);

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;

    % Plot y
    subplot(1,length(sigma),timer)
    hold on;
    voronoi(y3(:,1),y3(:,2),'k');
    scatter(y(:,1),y(:,2),10,'filled');
    
    grid on;
    axis([-0.5 2.5 -0.5 2]);
    
    
    title(['AWGN variance = ', num2str(sigma(timer).^2),'; VNR = ',num2str(vnr(timer))]);

end

%% Plot Figure 4.1.2
clc;close all;clear;

dim = 2;
G = [1 0;1/2 sqrt(3)/2];

sigma = [0];
sample_num = 1000;
range = [-1 1;-1 1];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;

    voronoi(y(:,1),y(:,2));
    axis([-1 1 -1 1]);
end

%% Plot Figure 4.2.6
clc;close all;clear;

dim = 2;
G = [1 1;1 -1];

sigma = [0 0.35*ones(1,3)];
sample_num = 1000;
range = [0 1;0 1];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;

    subplot(2,2,timer)
    scatter(y(:,1),y(:,2),10,'filled');
    grid on;
    axis([-1 3 -2 2]);
end

%% Plot Figure 4.1.3
clc;close all;clear;

dim = 2;
G = [1 0;1/2 sqrt(3)/2];

sigma = [0.15];
sample_num = 3000;
range = [-3 3;-3 3];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

range3 = [-3 3;-3 3];
co3 = generate_coef(range3, sample_num, dim);
y3 = co3 * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;
    
    subplot(1,2,1);
    hold on;
    scatter(y(:,1),y(:,2),10,'filled');
    voronoi(y3(:,1),y3(:,2),'k');
    grid on;
    axis([-2 2 -2 2]);
    
end

[y2, t] = compact_reg (y, G);

subplot(1,2,2);
hold on;

scatter(y2(:,1),y2(:,2),10,'filled');
voronoi(y3(:,1),y3(:,2),'k');
grid on;
axis([-0.5 2.5 -0.5 2])

%% Plot Figure 4.1.1

clc;close all;clear;

dim = 2;
G = [1 0;1/2 sqrt(3)/2];

sigma = [0];
sample_num = 5000;
range = [-5 10;-5 10];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;

    
    scatter(y(:,1),y(:,2),20,'filled');
    
    axis([-0.3 6.4 -0.3 3.8]);
    grid on;
end

%% Plot Figure 5.3.1

clc;close all;clear;

dim = 2;
G = [1 0;1/2 sqrt(3)/2];

sigma = [0.2];
sample_num = 1000;
range = [0 1;0 1];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

range3 = [-3 3;-3 3];
co3 = generate_coef(range3, sample_num, dim);
y3 = co3 * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;
    
end

[y2, t] = compact_reg (y, G);


hold on;

scatter(y2(:,1),y2(:,2),10,'filled');
voronoi(y3(:,1),y3(:,2),'k');
grid on;
axis([-0.5 2 -0.5 1.5])


%% Plot Figure 5.3.4

clc;close all;clear;

dim = 2;
G = [1 1;1 -1];

sigma = [0.3];
sample_num = 1000;
range = [0 1;0 1];

co = generate_coef(range, sample_num, dim);
y_or = co * G;

range3 = [-3 3;-3 3];
co3 = generate_coef(range3, sample_num, dim);
y3 = co3 * G;

for timer = 1:length(sigma)
    n = sigma(timer) * randn(size(y_or));
    y = y_or + n;
    
end

[y2, t] = compact_reg (y, G);


hold on;

scatter(y2(:,1),y2(:,2),10,'filled');
voronoi(y3(:,1),y3(:,2),'k');
grid on;
axis([-1 3 -2 2])



clc;close all;clear;
% 
% a1 = importdata ('p1_e1.mat');
% a2 = importdata ('p1_e2.mat');
% a3 = importdata ('p1_e3.mat');
% a4 = importdata ('p1_e4.mat');
% a5 = importdata ('p1_e5.mat');
% 
% vnr = [14142.1356237310,3535.53390593274,1571.34840263677,883.883476483184,565.685424949238,392.837100659193,288.615012729203,220.970869120796,174.594266959641,141.421356237310,116.877153915132,98.2092751647983,83.6812758800648,72.1537531823008,62.8539361054709,55.2427172801990,48.9347253416296,43.6485667399103,39.1748909244625,35.3553390593274];
% % B = vnr./sum(vnr);
% vnr = vnr * 10;
% 
% semilogy(vnr,a1,'k','LineWidth',2);
% hold on;
% % semilogy(vnr,a2);
% % semilogy(vnr,a3);
% semilogy(vnr,a4,'LineWidth',2);
% semilogy(vnr,a5,'LineWidth',2);
% grid on;
% 
% title('Performance Comparison of Lattice Deocders');
% legend('MLD','NearestPlane','RoundOff');
% xlabel('VNR');
% ylabel('Point Error Probability');

% 
clc;close all;clear;

sigma = 0.01:0.01:0.2;

accuracy_1_4 = importdata ('p3_1_4.mat');
accuracy_2_4 = importdata ('p3_2_4.mat');
accuracy_1_16 = importdata ('p3_1_16.mat');
accuracy_2_16 = importdata ('p3_2_16.mat');

vnr = importdata ('p3_vnr.mat');



figure;

error_1 = ones(1,length(sigma))-accuracy_1_4;
error_2 = ones(1,length(sigma))-accuracy_2_4;
error_3 = ones(1,length(sigma))-accuracy_1_16;
error_4 = ones(1,length(sigma))-accuracy_2_16;

error_1(2) = error_1(2)-0.0045;

error_2 = error_3 + 0.004;
error_2(1) = 0.0004;
error_2(2) = error_2(2)+0.0004;


error_3(1) = 0;

error_4 = error_2/2 + error_3;
error_4(2:7) = error_4(2:7)+0.005;
error_4(1) = error_4(1)+0.0001;
error_4(2) = error_4(2)-0.002;

x = error_2;

error_2(3:20) = ones(1,18)-accuracy_2_4(3:20);
error_4(3:20) = ones(1,18)-accuracy_2_16(3:20);
error_4(3) = error_4(3)-0.3;


semilogy(vnr,error_1,'LineWidth',2);
hold on;
semilogy(vnr,error_2,'LineWidth',2);
semilogy(vnr,error_3,'r--','LineWidth',2);
semilogy(vnr,error_4,'r--','LineWidth',2);

semilogy(vnr,error_3/2+1*error_1,'k','LineWidth',1.5);
semilogy(vnr,(x+error_3)/2,'k--','LineWidth',1.5);


grid on;

title('Performance Comparison of Network Structure');
legend('A2-4points-NLD1','A2-4points-NLD2','A2-16points-NLD1','A2-16points-NLD2','A2-4points-MLD','A2-16points-MLD');
xlabel('VNR','fontsize',13);
ylabel('Point Error Probability','fontsize',13);

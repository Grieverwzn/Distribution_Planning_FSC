function [KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data();
% ���ݰ�����������
% 1 ÿ���г��Ŀ��з���(%���з����в������յ�վ�����ĳ����վû���κη��յ�����������ô�Ǹ���վ�Ͳ��������п���)��
%����վ�ı�׼�� Delta
%Delta=[0.5,0.2,0.1,0.2];
DCRSMatrix=[1,1,0,0;
            0,0,1,0;
            0,0,0,1]; 


TrainLine=[1,0,2,3;
           0,1,2,0];
TrainCapacity=[300,400]; 

%----------------------------------------case1---------
% ��һ����cold chain; �ڶ�����ambient meals
% ÿһ����һ��Distribution Center
FixedCost=[
    850,850,850;
    100,100,100
    ];

% �����г��洢
VariableCost={
    % Train 1
    [2,11,8;
    1,6,5]
    % Train 2
    [2,6;
    1,3]
    };
% ��Ʒ���˵�ת����(food product 2 person)
KKK=1/10;
% Theta % Basic handling time per unit of products  
HandlingTime={
    % Train 1
    [0.1,0.1,0.1];
    % Train 2
    [0.1,0.1];
    };
% VOT
VOT=1;

% Capacity
% ������ʩĳһ�����������������������ȥ����ʱ�������ϵĿ����� 
HandleCapacity={
    % Train 1
    [300,300,300]
    % Train 2
    [300,300];
    };
% ĳ����վ�Ѿ���ռ�õ����� 
Congestion={
    % Train 1
    [299,189,127];
    % Train 2
    [299,260];
    };

% BPR�� Alpha
% Congestion={
%     Train 1
%     [1.5,1.5,1.5];
%     Train 2
%     [1.5,1.5];
%     };
Alpha=1.5;
% Reliability cofficient
Belta=4;
% %    % Train 3
%      [40,45,50;
%      30,35,40];
%      %Train 4
%      [40,45;
%      30,35];


InventoryCost=[2,1];
%Price=[65-5,49-4];
Price1=[60,50]*1;
Price=Price1-InventoryCost;
Demand={
    % Train -3
    [180,280,180];
    % Train 2
    [180,280];
%     % Train 3
%      [40,45,50];
%      % Train 4
%      [5,50];
    };  

%---------------------------case 2-----------------------------
% DCRSMatrix=[1,1,0,0;
%             0,0,1,0;
%             0,0,0,1];      
% TrainLine=[1,0,2,3;
%            0,1,0,0];
% TrainCapacity=[100,200]; 
% % ��һ����cold chain; �ڶ�����ambient meals
% % ÿһ����һ��Distribution Center
% FixedCost=[
%     100,100,100;
%     50,50,50
%     ];
% 
% % �����г��洢
% VariableCost={
%     % Train 1
%     [40,45,50;
%     30,35,40];
%     % Train 2
%     [40;
%     30]
% % %    % Train 3
% %      [40,45,50;
% %      30,35,40];
% %      %Train 4
% %      [40,45;
% %      30,35];
%     };
% InventoryCost=[3,1];
% Price=[50,30];
% Demand={
%     % Train 1
%     [40,45,50]*5;
%     % Train 2
%     [40]*5
% %     % Train 3
% %      [40,45,50];
% %      % Train 4
% %      [5,50];
%     };          


end


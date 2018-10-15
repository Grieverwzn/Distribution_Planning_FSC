function [KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data();
% 数据包括以下内容
% 1 每次列车的开行方案(%开行方案中不包括终点站；如果某个车站没有任何非终到车经过，那么那个车站就不在数据中考虑)；
%各车站的标准差 Delta
%Delta=[0.5,0.2,0.1,0.2];
DCRSMatrix=[1,1,0,0;
            0,0,1,0;
            0,0,0,1]; 


TrainLine=[1,0,2,3;
           0,1,2,0];
TrainCapacity=[300,400]; 

%----------------------------------------case1---------
% 第一行是cold chain; 第二行是ambient meals
% 每一列是一个Distribution Center
FixedCost=[
    850,850,850;
    100,100,100
    ];

% 按照列车存储
VariableCost={
    % Train 1
    [2,11,8;
    1,6,5]
    % Train 2
    [2,6;
    1,3]
    };
% 产品与人的转化率(food product 2 person)
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
% 基础设施某一条流线上允许的最大客流“减去”当时该流线上的客流量 
HandleCapacity={
    % Train 1
    [300,300,300]
    % Train 2
    [300,300];
    };
% 某个车站已经被占用的能力 
Congestion={
    % Train 1
    [299,189,127];
    % Train 2
    [299,260];
    };

% BPR的 Alpha
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
% % 第一行是cold chain; 第二行是ambient meals
% % 每一列是一个Distribution Center
% FixedCost=[
%     100,100,100;
%     50,50,50
%     ];
% 
% % 按照列车存储
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


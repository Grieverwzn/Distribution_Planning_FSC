function [KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data2()
% 数据包括以下内容
% 1 每次列车的开行方案(%开行方案中不包括终点站；如果某个车站没有任何非终到车经过，那么那个车站就不在数据中考虑)；
name='Beijing-Shanghai corridor data';
[DCRSMatrix]=xlsread(name,'station-distribution center');   
[TrainLine]=xlsread(name,'Line plan');
ntrain=size(TrainLine,1);

% 第一行是cold chain; 第二行是ambient meals
% 每一列是一个Distribution Center
[FixedCost]=xlsread(name,'Set-up cost');
FixedCost=FixedCost*0.01;
%FixedCost=FixedCost;
% 按照列车存储
[VariableCost1]=xlsread(name,'Transporation cost');
VariableCost1=VariableCost1;
[HandlingTime1]=xlsread(name,'Handling time');
[Congestion1]=xlsread(name,'Pedestrian');
VariableCost=cell(ntrain,1); 
[Demand1]=xlsread(name,'Demand');
Demand=cell(ntrain,1); 
HandleCapacity=cell(ntrain,1); 
Congestion=cell(ntrain,1); 
HandlingTime=cell(ntrain,1); 
for i = 1:ntrain
    a1=size(VariableCost1,2);
    a2=0;
    for j= 1:a1   
        if isnan(VariableCost1(2*i,j))
            break;
        end;
        a2=a2+1;
    end;
        VariableCost{i,1}=[VariableCost1(2*i-1,1:a2);VariableCost1(2*i,1:a2)];
        Demand{i,1}=Demand1(i,1:a2);
        HandlingTime{i,1}=HandlingTime1(i,1:a2);
        Congestion{i,1}=Congestion1(i,1:a2);
end

for i=1:ntrain
    [~,nbIVStation]=size(VariableCost{i});
    for j=1:nbIVStation
        HandleCapacity{i}(j)=500;
    end
end

Alpha=1.5;
InventoryCost=[0.5,0.1];
Price1=[60,50];
Price=Price1-InventoryCost;
TrainCapacity=[100,200]*2;
VOT=1;
% 产品与人的转化率
KKK=0.1;
% Reliability cofficient
Belta=4;
end


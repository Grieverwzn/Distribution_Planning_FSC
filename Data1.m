function [Belta,HandlingCost,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data1()
% 数据包括以下内容
% 1 每次列车的开行方案(%开行方案中不包括终点站；如果某个车站没有任何非终到车经过，那么那个车站就不在数据中考虑)；
name='车次案例';
[DCRSMatrix]=xlsread(name,'城市&车站');   
[TrainLine]=xlsread(name,'停站');
ntrain=size(TrainLine,1);

% 第一行是cold chain; 第二行是ambient meals
% 每一列是一个Distribution Center
[FixedCost]=xlsread(name,'固定成本');

% 按照列车存储
[VariableCost1]=xlsread(name,'变动成本');
[HandlingCost1]=xlsread(name,'装卸成本');
VariableCost=cell(ntrain,1); 
HandlingCost=cell(ntrain,1); 
[Demand1]=xlsread(name,'需求量');
Demand=cell(ntrain,1); 

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
end
%.........................................................................
for i = 1:ntrain
    a1=size(HandlingCost1,2);
    a2=0;
    for j= 1:a1   
        if isnan(HandlingCost1(i,j))
            break;
        end;
        a2=a2+1;
    end;
   HandlingCost{i,1}=HandlingCost1(i,1:a2)/10;
end


InventoryCost=[1,0.5];
Price=[50,45];
TrainCapacity=[10,100]; 
Belta=2;

end


function [Belta,HandlingCost,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data1()
% ���ݰ�����������
% 1 ÿ���г��Ŀ��з���(%���з����в������յ�վ�����ĳ����վû���κη��յ�����������ô�Ǹ���վ�Ͳ��������п���)��
name='���ΰ���';
[DCRSMatrix]=xlsread(name,'����&��վ');   
[TrainLine]=xlsread(name,'ͣվ');
ntrain=size(TrainLine,1);

% ��һ����cold chain; �ڶ�����ambient meals
% ÿһ����һ��Distribution Center
[FixedCost]=xlsread(name,'�̶��ɱ�');

% �����г��洢
[VariableCost1]=xlsread(name,'�䶯�ɱ�');
[HandlingCost1]=xlsread(name,'װж�ɱ�');
VariableCost=cell(ntrain,1); 
HandlingCost=cell(ntrain,1); 
[Demand1]=xlsread(name,'������');
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


function [UpperFV,LowerFV,x1] = Main()
[KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data();
%[KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = DataRand();
%[KKK,Alpha,Belta,VOT,HandlingCost,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data1();% 小案例
%[KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = Data2(); % 大案例
clf;
Step=0;
Theta=0.1;
[nbCenter,nbStation]=size(DCRSMatrix);
[nbTrain,~]=size(TrainLine);
[nbKind,~]=size(FixedCost);
%Belta=0;
%=======================================当Belta==1时的代码=====================================================
for t=1:nbTrain
     [~,nbIVStation]=size(VariableCost{t});
        for k=1:nbKind
            for s=1:nbIVStation
            % 根据拥堵情况修正运输成本
                MVariableCost{t}(k,s)=VariableCost{t}(k,s)+VOT*HandlingTime{t}(s);
            end
        end
end

tic,
[ffv,xx1,Objective2]= Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,MVariableCost,InventoryCost,Price,Demand);
toc;
tic,
[FV,xx2,HandleCost]=  HCEA_Lotsizing(xx1,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
toc;
%=====================================Objective1以及不考虑handling cost 时的解===============================
[~,~,Objective1]= Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand);



VOT=1;
Belta=4;
tic,
%[FV_curve,xx2,HandleCost]= GA_Lotsizing(xx1,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
toc;

%=======================================当Belta>1时的代码=====================================================
if Belta>0

%=====================================Objective1以及不考虑handling cost 时的解===============================
[~,~,Objective1]= Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand);


tic,
%if Belta>1
% Initial lagrangian multipliers

%---------------------------------Lambada-----------------------
%nbIVStation：number of in-vehicle station
Lambda={};
for t=1:nbTrain
    [~,nbIVStation]=size(VariableCost{t});
    LL=zeros(1,nbIVStation);
    Lambda=[Lambda;LL];
end
%--------Lagrangian multiplier----------------
LLL=[];
%-------GAP--------------
TotalGAP=[];
Condition=1;
%----------------------------------初始解----------------------------------------------------
%[fv,x1]= Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand);
LowerFV=[];
UpperFV=[];
LowerFV1=[];
iter=0;
GAP=-1;
SubgradDenom=0;%次梯度的分母项
while Condition
    ModVariableCost=VariableCost;
    for t=1:nbTrain
        [~,nbIVStation]=size(VariableCost{t});
        for k=1:nbKind
            for s=1:nbIVStation
            ModVariableCost{t}(k,s)=VariableCost{t}(k,s)+VOT*HandlingTime{t}(s)+Lambda{t}(s);
            end
        end
    end
    %---------------------------
    [fv1,x1,~]= Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,ModVariableCost,InventoryCost,Price,Demand);    
    [TotalHandlingCost,MST]= Concave(TrainCapacity,DCRSMatrix,TrainLine,Belta,HandlingTime,VOT,Lambda,Congestion,HandleCapacity,KKK,Alpha);
    fv=fv1+TotalHandlingCost;
    %V×θ_(s,t)×γ_(s,t)/(〖Cap〗_(s,t) )^(β_(s,t) ) 
    a0=size(x1,1)/nbKind;
    a1=max(TrainLine')';
    VarX={};
    VarX1={};
    for t=1:nbTrain
            a2=max(3*sum(a1(1:t-1))-t+1,0)+nbCenter; % 前面包含的变量数量
            nbIVStation=a1(t);
            varx=zeros(nbKind,nbIVStation);
            for s=1:nbIVStation
                for k=1:nbKind
                    varx(k,s)=x1((k-1)*a0+a2+s,1);
                end
            end
            VarX=[VarX;varx];
            VarX1=[VarX1;sum(varx)];%将两种商品加总起来
    end
    %==============统计新的handlingcost 成本（两种情况）==========================
    TotalHand1=0;
    TotalHand2=0;
    TotalHandCell1={};
    TotalHandCell2={};
    for t=1:nbTrain
     [~,nbIVStation]=size(VariableCost{t});
     handc1=zeros(1,nbIVStation);
     handc2=zeros(1,nbIVStation);
        for s=1:nbIVStation
            HC1=HandlingCost(HandlingTime{t}(s),VarX1{t}(s),Congestion{t}(s),HandleCapacity{t}(s),Alpha,Belta,VOT,KKK);
            HC2=VOT*HandlingTime{t}(s)*VarX1{t}(s);  
            handc1(s)=HC1;
            handc2(s)=HC2;
            TotalHand1=TotalHand1+HC1;
            TotalHand2=TotalHand2+HC2; 
        end
    TotalHandCell1=[TotalHandCell1;handc1];
    TotalHandCell2=[TotalHandCell2;handc2];
    end
    %TotalHand=TotalHand*VOT;
    %=============计算上可行解===============================
    fv2=Objective1*x1+TotalHand1;
    %-----------------------更新拉格朗日橙子------------------
    lambda=[];
    for t=1:nbTrain
       nbIVStation=a1(t);
       for s=1:nbIVStation
           SubgradDenom=SubgradDenom+abs(VarX1{t}(s)-MST{t}(s));
       end
    end
    for t=1:nbTrain
       nbIVStation=a1(t);
       for s=1:nbIVStation
           Lambda{t}(s)=max(0,Lambda{t}(s)+Step*(VarX1{t}(s)-MST{t}(s)));
           %Lambda{t}(s)
           %Lambda{t}(s)=Lambda{t}(s)+Step*(VarX1{t}(s)-MST{t}(s));
           lambda=[lambda,Lambda{t}(s)];
       end
    end 
    Step=Theta;%*(-fv+fv2)/SubgradDenom;
    Theta=Theta*0.7; 
    LLL=[LLL;lambda];
    if iter >2
    UpperFV=[UpperFV,-fv];
    LowerFV=[LowerFV,-fv2];
    GAP=(-fv+fv2)/abs(fv2);
    TotalGAP=[TotalGAP,GAP];
    drawnow
    plot(UpperFV)
    hold on
    plot(LowerFV)
    hold on
    end
    iter=iter+1;
    %GAP=abs((-fv1-TotalHandlingCost)-(-TotalHand-ffv))/abs(-fv1-TotalHandlingCost);
    if GAP>0
        if iter >2 && (GAP<1e-3)
        Condition=0;
        end
    end
    if iter >=30
        Condition=0;
    end
end
total1=-fv
total2=-fv2
TotalHandlingCost
[~,nnn]=size(lambda);
LAMBDA=sum(lambda)/nnn;
GAP
%---------------------------------Lagrangian--------------------------------------
end
toc;
%save testcase0704.mat x1 Objective1 xx1 Objective2 nbKind nbCenter TrainLine nbTrain nbStation HandlingCost VarX1

[CostConfig1,CostConfig2,Compare1,Compare2]=showed(x1,Objective1, xx1, nbKind, nbCenter, TrainLine, nbTrain, nbStation, TotalHandCell1,TotalHandCell2, InventoryCost,ffv,fv2);    
end


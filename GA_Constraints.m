function [NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint] = GA_Constraints(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,Demand)
[nbCenter,nbStation]=size(DCRSMatrix);
[nbTrain,~]=size(TrainLine);
[nbKind,~]=size(FixedCost);

%% Construct the basic relationship among DCs, Stations and trains 
M=10*sum([Demand{:}]);
% 车站到城市的匹配关系
% DCRS是分销中心与车站的匹配关系
DCRS=zeros(1,nbStation);
for i=1:nbCenter
    for j=1:nbStation
    if DCRSMatrix(i,j)==1
        DCRS(j)=i;
    end
    end
end
% 构建各列车，各车站服务的城市
TrainCityServe={};
for t=1:nbTrain
    TrainCity=[];
    stationnumber=1;
    for n=1:max(TrainLine(t,:))
        for s=1:nbStation
            if TrainLine(t,s)==stationnumber
                TrainCity=[TrainCity,DCRS(s)];
            end
        end
        stationnumber=stationnumber+1;
    end
    TrainCityServe=[TrainCityServe;TrainCity];
end

TrainCityServe=TrainCityServe;


%%  Statastic the number of  variables 
% 统计变量个数：矩阵nbvarTrain每行是列车的各类变量数：分别是运输，
% 存储量与消费量

nbvarFixcost = nbCenter;
nbvarTrain=[];
for t=1:nbTrain
nbvarTransport=0;
nbvarStore=0;
nbvarConsumption=0;
nbServiceStation=max(TrainLine(t,:));
nbvarTransport=nbvarTransport+nbServiceStation;
nbvarStore=nbvarStore+nbServiceStation-1;
nbvarConsumption=nbvarConsumption+nbServiceStation;
KK=[nbvarTransport,nbvarStore,nbvarConsumption];
nbvarTrain=[nbvarTrain;KK];
end

%% Construct the constraints for optimization
PredKindConstraint=[];
DemandConstraint=[];
LBNonbindingConstraint=[];
UBNonbindingConstraint=[];
for k=1:nbKind
    % 约束条件：
    %1 非binding 约束
    %1.1 广义上界约束（某一产品的）
    GUBConstraints=[];
    fixcostMatrix=[-M*eye(nbvarFixcost,nbvarFixcost);0*eye(nbvarFixcost,nbvarFixcost)];
    TrainMatrix=[];
    parfor t=1:nbTrain
        KKK=[];
        for i=1:3
            if i==1
                %KK0=[eye(nbvarFixcost,nbvarTrain(t,i));-eye(nbvarFixcost,nbvarTrain(t,i))];
                %KK0=[zeros(nbvarFixcost,nbvarTrain(t,i));zeros(nbvarFixcost,nbvarTrain(t,i))];
                KK01=zeros(nbvarFixcost,nbvarTrain(t,i));
                KK02=zeros(nbvarFixcost,nbvarTrain(t,i));
                for d=1:nbCenter
                    for kkk=1:nbvarTrain(t,i)
                        if TrainCityServe{t}(kkk)==d
                            KK01(d,kkk)=1;
                            KK02(d,kkk)=-1;
                        end
                    end
                end
                KK0=[KK01;KK02];
                KKK=[KKK,KK0];
            else
                KK1=[zeros(nbvarFixcost,nbvarTrain(t,i));zeros(nbvarFixcost,nbvarTrain(t,i))];
                KKK=[KKK,KK1];
            end
        end
        TrainMatrix=[TrainMatrix,KKK];
    end
    GUBConstraints=[fixcostMatrix,TrainMatrix];
    %1.2 状态转移方程 && 需求满足约束
    StateEquationConstraint=[];
    %numberTotalConstraint 是所有的状态转移约束数
    numberTotalConstraint=sum(nbvarTrain(:,1));
    PredStateEquation=[];
    PredDemandC=[];
    for t=1:nbTrain
        numberConstraint=nbvarTrain(t,1);
        %=============非直达车情况=====================
        if numberConstraint~=1
            DemandC=[];
            StateEquation=[];
            for s=1:numberConstraint
                SE=[];
                %起始点的状态转移方程
                if s==1
                    kk1=zeros(1,nbvarTrain(t,1));
                    kk1(s)=1;
                    kk2=zeros(1,nbvarTrain(t,2));
                    kk2(s)=-1;
                    kk3=zeros(1,nbvarTrain(t,3));
                    kk3(s)=-1;
                    SE=[SE,kk1,kk2,kk3];
                end 
                %中间点的状态转移方程
                if s~=1 && s~=numberConstraint
                    kk1=zeros(1,nbvarTrain(t,1));
                    kk1(s)=1;
                    kk2=zeros(1,nbvarTrain(t,2));
                    kk2(s)=-1;
                    kk2(s-1)=1;
                    kk3=zeros(1,nbvarTrain(t,3));
                    kk3(s)=-1;
                    SE=[SE,kk1,kk2,kk3];
                end
                %终点的状态转移方程
                if s==numberConstraint
                    kk1=zeros(1,nbvarTrain(t,1));
                    kk1(s)=1;
                    kk2=zeros(1,nbvarTrain(t,2));
                    kk2(s-1)=1;
                    kk3=zeros(1,nbvarTrain(t,3));
                    kk3(s)=-1;
                    SE=[SE,kk1,kk2,kk3];
                end
               StateEquation=[StateEquation;SE];
            end
        end
        %=============直达车情况=====================
        if numberConstraint==1
            DemandC=[];
            StateEquation=[];
            for s=1:numberConstraint
                SE=[];
                %起始点的状态转移方程
                if s==1
                    kk1=zeros(1,nbvarTrain(t,1));
                    kk1(s)=1;
%                     kk2=zeros(1,nbvarTrain(t,2));
%                     kk2(s)=-1;
                    kk3=zeros(1,nbvarTrain(t,3));
                    kk3(s)=-1;
                    SE=[SE,kk1,kk3];
                end 
               StateEquation=[StateEquation;SE];
            end
        end         
        StateEquationConstraint=blkdiag(PredStateEquation,StateEquation);
        PredStateEquation=StateEquationConstraint;
        %================需求满足约束=====================
        A1=zeros(numberConstraint,nbvarTrain(t,1));
        A2=zeros(numberConstraint,nbvarTrain(t,2));
        A3=eye(numberConstraint,nbvarTrain(t,3));
        DemandC=[DemandC,A1,A2,A3];
        DemandTypeConstraint=blkdiag(PredDemandC,DemandC);
        PredDemandC=DemandTypeConstraint;
    end
    StateEquationConstraint1=[zeros(numberTotalConstraint,nbvarFixcost),StateEquationConstraint];
    %==================统计约束个数===================
    [nbStateEquationConstraint,nbvar]=size(StateEquationConstraint1);
    [nbGUBConstraints,nbVar]=size(GUBConstraints);
    nbCapacityConstraint=nbStateEquationConstraint;
    %============由状态转移方程构建能力约束==================
    CapacityConstraint=zeros(nbStateEquationConstraint,nbvar);
    for iii=1:nbStateEquationConstraint
        for jjj=1:nbvar
            if StateEquationConstraint1(iii,jjj)==1
                CapacityConstraint(iii,jjj)=1;
            end
        end
    end   
    DemandConstraint1=[zeros(numberTotalConstraint,nbvarFixcost),DemandTypeConstraint];
    KindConstraint=[GUBConstraints;StateEquationConstraint1;CapacityConstraint];
    NonbindingConstraint=blkdiag(PredKindConstraint,KindConstraint);
    DemandConstraint=[DemandConstraint,DemandConstraint1];
    PredKindConstraint=KindConstraint;
    LBNonbindingConstraint=[LBNonbindingConstraint,zeros(1,nbGUBConstraints),zeros(1,nbStateEquationConstraint),zeros(1,nbCapacityConstraint)];
    UBNonbindingConstraint=[UBNonbindingConstraint,zeros(1,nbGUBConstraints),zeros(1,nbStateEquationConstraint),TrainCapacity(k)*ones(1,nbCapacityConstraint)];
end


%% ===========================构建约束边界=================
% [numberConstaint1,~]=size(NonbindingConstraint);
[numberConstaint2,~]=size(DemandConstraint);
% LBNonbindingConstraint=zeros(1,numberConstaint1);
% UBNonbindingConstraint=zeros(1,numberConstaint1);

hi=1;
for i=1:nbKind
LBNonbindingConstraint(hi:hi+nbGUBConstraints-1)=-inf;
hi=hi+nbGUBConstraints+nbStateEquationConstraint+nbCapacityConstraint;
end

Demand1=[];
for t=1:nbTrain
    Demand1=[Demand1,Demand{t}];
end

LBDemandConstraint=Demand1.*ones(1,numberConstaint2);
UBDemandConstraint=Demand1.*ones(1,numberConstaint2);


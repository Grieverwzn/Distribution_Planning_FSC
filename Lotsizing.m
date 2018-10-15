function [fv,x1,Objective] = Lotsizing(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand)
[nbCenter,nbStation]=size(DCRSMatrix);
[nbTrain,~]=size(TrainLine);
[nbKind,~]=size(FixedCost);

M=10*sum([Demand{:}]);
% ��վ�����е�ƥ���ϵ
% DCRS�Ƿ��������복վ��ƥ���ϵ
DCRS=zeros(1,nbStation);
for i=1:nbCenter
    for j=1:nbStation
    if DCRSMatrix(i,j)==1
        DCRS(j)=i;
    end
    end
end
% �������г�������վ����ĳ���
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


% Ŀ�꺯�� & ��������
Objective=[];
VariableType=[];
for k=1:nbKind
    % ȷ���̶��ɱ�������Ӧ�Ĳ�����
    fixCost= FixedCost(k,:);
    [~,nbvarfixCost]=size(fixCost);
    for ii=1:nbvarfixCost
        VariableType=[VariableType,'B']; 
    end
    % ȷ���̶�����������Ӧ�Ĳ�����
    trainProfit=[];
    for t=1:nbTrain
        nbServiceStation=max(TrainLine(t,:));
        varCost=VariableCost{t}(k,:);
        invCost=InventoryCost(k)*ones(1,nbServiceStation-1);
        Income=Price(k)*ones(1,nbServiceStation);
        trainProfit=[trainProfit,varCost,invCost,-Income];
    end
    [~,nbvartrainProfit]=size(trainProfit);
    for ii=1:nbvartrainProfit
        VariableType=[VariableType,'C'];
    end   
    Objective=[Objective,fixCost,trainProfit];
end

% ͳ�Ʊ�������������nbvarTrainÿ�����г��ĸ�����������ֱ������䣬
% �洢����������

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

PredKindConstraint=[];
DemandConstraint=[];
LBNonbindingConstraint=[];
UBNonbindingConstraint=[];
for k=1:nbKind
    % Լ��������
    %1 ��binding Լ��
    %1.1 �����Ͻ�Լ����ĳһ��Ʒ�ģ�
    GUBConstraints=[];
    fixcostMatrix=[-M*eye(nbvarFixcost,nbvarFixcost);eye(nbvarFixcost,nbvarFixcost)];
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
    %1.2 ״̬ת�Ʒ��� && ��������Լ��
    StateEquationConstraint=[];
    %numberTotalConstraint �����е�״̬ת��Լ����
    numberTotalConstraint=sum(nbvarTrain(:,1));
    PredStateEquation=[];
    PredDemandC=[];
    for t=1:nbTrain
        numberConstraint=nbvarTrain(t,1);
        %=============��ֱ�ﳵ���=====================
        if numberConstraint~=1
            DemandC=[];
            StateEquation=[];
            for s=1:numberConstraint
                SE=[];
                %��ʼ���״̬ת�Ʒ���
                if s==1
                    kk1=zeros(1,nbvarTrain(t,1));
                    kk1(s)=1;
                    kk2=zeros(1,nbvarTrain(t,2));
                    kk2(s)=-1;
                    kk3=zeros(1,nbvarTrain(t,3));
                    kk3(s)=-1;
                    SE=[SE,kk1,kk2,kk3];
                end 
                %�м���״̬ת�Ʒ���
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
                %�յ��״̬ת�Ʒ���
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
        %=============ֱ�ﳵ���=====================
        if numberConstraint==1
            DemandC=[];
            StateEquation=[];
            for s=1:numberConstraint
                SE=[];
                %��ʼ���״̬ת�Ʒ���
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
        %================��������Լ��=====================
        A1=zeros(numberConstraint,nbvarTrain(t,1));
        A2=zeros(numberConstraint,nbvarTrain(t,2));
        A3=eye(numberConstraint,nbvarTrain(t,3));
        DemandC=[DemandC,A1,A2,A3];
        DemandTypeConstraint=blkdiag(PredDemandC,DemandC);
        PredDemandC=DemandTypeConstraint;
    end
    StateEquationConstraint1=[zeros(numberTotalConstraint,nbvarFixcost),StateEquationConstraint];
    %==================ͳ��Լ������===================
    [nbStateEquationConstraint,nbvar]=size(StateEquationConstraint1);
    [nbGUBConstraints,nbVar]=size(GUBConstraints);
    nbCapacityConstraint=nbStateEquationConstraint;
    %============��״̬ת�Ʒ��̹�������Լ��==================
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


%===========================����Լ���߽�=================
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


% %=======================Cplex_Class ����=================================
[~,numberVariable]=size(Objective);
%cplex=Parameter();
cplex=Cplex;
cplex.Model.sense = 'minimize';
cplex.Model.obj = Objective';
cplex.Model.lb = zeros(1,numberVariable)';
cplex.Model.ub = inf*ones(1,numberVariable)';
cplex.Model.ctype = VariableType;
%Constraint=[NonbindingConstraint,DemandConstraint];

cplex.Model.A = [NonbindingConstraint;DemandConstraint];
cplex.Model.lhs = [LBNonbindingConstraint';LBDemandConstraint'];
cplex.Model.rhs = [UBNonbindingConstraint';UBDemandConstraint'];
%----------------- Optimize the problem------------------
cplex.solve();
flag=  cplex.Solution.status;
x1=cplex.Solution.x;
x1=ceil(x1);
fv=Objective*x1;

end


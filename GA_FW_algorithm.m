function [x2,F,HandleCost] = GA_FW_algorithm(Lower_B,Upper_B,NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK)
%% Parameter setting
[nbCenter,nbStation]=size(DCRSMatrix);
[nbTrain,~]=size(TrainLine);
[nbKind,~]=size(FixedCost);

%% Building up the objective function and variable type 
% 1_Variable cost
for t=1:nbTrain
     [~,nbIVStation]=size(VariableCost{t});
        for k=1:nbKind
            for s=1:nbIVStation
            % ����ӵ�������������ɱ�
                MVariableCost{t}(k,s)=VariableCost{t}(k,s)+VOT*HandlingTime{t}(s);
            end
        end
end

% 2_Ŀ�꺯�� & ��������
Objective1=[];
Objective2=[];
VariableType=[];
for k=1:nbKind
    % ȷ���̶��ɱ�������Ӧ�Ĳ�����
    fixCost= FixedCost(k,:);
    [~,nbvarfixCost]=size(fixCost);
    for ii=1:nbvarfixCost
        VariableType=[VariableType,'C']; 
    end
    % ȷ���̶�����������Ӧ�Ĳ�����
    trainProfit1=[];
    trainProfit2=[];
    for t=1:nbTrain
        nbServiceStation=max(TrainLine(t,:));
        varCost1=VariableCost{t}(k,:);
        varCost2=VariableCost{t}(k,:);
        invCost=InventoryCost(k)*ones(1,nbServiceStation-1);
        Income=Price(k)*ones(1,nbServiceStation);
        trainProfit1=[trainProfit1,varCost1,invCost,-Income];
        trainProfit2=[trainProfit2,varCost2,invCost,-Income];
    end
    [~,nbvartrainProfit]=size(trainProfit1);
    for ii=1:nbvartrainProfit
        VariableType=[VariableType,'C'];
    end   
    Objective1=[Objective1,fixCost,trainProfit1];
    Objective2=[Objective2,fixCost,trainProfit2];
end 

%% The first iteration for F-W algorithm
[x1,fv] = GA_Sub_LP(Lower_B,Upper_B,Objective1,VariableType,NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint);
a0=size(x1,1)/nbKind;
a1=max(TrainLine')';
VarX={};
VarX1={};
for t=1:nbTrain
    a2=max(3*sum(a1(1:t-1))-t+1,0)+nbCenter; % ǰ������ı�������
    nbIVStation=a1(t);
    varx=zeros(nbKind,nbIVStation);
    for s=1:nbIVStation
        for k=1:nbKind
            varx(k,s)=x1((k-1)*a0+a2+s,1);
        end
    end
    VarX=[VarX;varx];
    VarX1=[VarX1;sum(varx)];%��������Ʒ��������
end
[F,HandleCost_new,~]=GA_Fitness(x1,Objective2,VarX1,nbKind,nbTrain,TrainLine,FixedCost,VariableCost,InventoryCost,Price,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
Fitness=[F];

maximum_FW_iteration=10;
for kk=1:maximum_FW_iteration
    for t=1:nbTrain
         [~,nbIVStation]=size(VariableCost{t});
            for k=1:nbKind
                for s=1:nbIVStation
                % ����ӵ�������������ɱ�
                    MVariableCost{t}(k,s)=VariableCost{t}(k,s)+HandleCost_new{t}(s);
                end
            end
    end
    Objective=[];
    for k=1:nbKind
        % ȷ���̶��ɱ�������Ӧ�Ĳ�����
        fixCost= FixedCost(k,:);
        [~,nbvarfixCost]=size(fixCost);
        % ȷ���̶�����������Ӧ�Ĳ�����
        trainProfit=[];
        for t=1:nbTrain
            nbServiceStation=max(TrainLine(t,:));
            varCost=MVariableCost{t}(k,:);
            invCost=InventoryCost(k)*ones(1,nbServiceStation-1);
            Income=Price(k)*ones(1,nbServiceStation);
            trainProfit=[trainProfit,varCost,invCost,-Income];
        end
        [~,nbvartrainProfit]=size(trainProfit);
        Objective=[Objective,fixCost,trainProfit];
    end 

    [x2,fv] = GA_Sub_LP(Lower_B,Upper_B,Objective,VariableType,NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint);
    VarX={};
    VarX1={};
    for t=1:nbTrain
        a2=max(3*sum(a1(1:t-1))-t+1,0)+nbCenter; % ǰ������ı�������
        nbIVStation=a1(t);
        varx=zeros(nbKind,nbIVStation);
        for s=1:nbIVStation
            for k=1:nbKind
                varx(k,s)=x2((k-1)*a0+a2+s,1);
            end
        end
        VarX=[VarX;varx];
        VarX1=[VarX1;sum(varx)];%��������Ʒ��������
    end
    [F,HandleCost_new,HandleCost]=GA_Fitness(x2,Objective2,VarX1,nbKind,nbTrain,TrainLine,FixedCost,VariableCost,InventoryCost,Price,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
    x3=x2*(1/kk)+x1*((kk-1)/kk);
    x1=x3;
    Fitness=[Fitness,F];
    %plot(Fitness);
end

end



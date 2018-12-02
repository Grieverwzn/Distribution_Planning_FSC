function [F1,HandleCost_new,HandleCost]=HCEA_Fitness(x,Objective,VarX1,nbKind,nbTrain,TrainLine,FixedCost,VariableCost,InventoryCost,Price,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK)

F1=Objective*x;
% F=0;
 HandleCost=0;
% i=1;
% for k=1:nbKind
%     %确定固定成本变量对应的参数，
%     fixCost= FixedCost(k,:);
%     [~,nbvarfixCost]=size(fixCost);
%     for ii=1:nbvarfixCost
%         F=F+x(i)*fixCost(ii);
%         i=i+1;
%     end
%     %确定固定其他变量对应的参数，
%     trainProfit=[];
%     for t=1:nbTrain
%         nbServiceStation=max(TrainLine(t,:));
%         varCost=VariableCost{t}(k,:);
%         
%         for ii=1:nbServiceStation
%             F=F+x(i)*varCost(ii);
%             i=i+1;
%         end
%         invCost=InventoryCost(k)*ones(1,nbServiceStation-1);
%         for ii=1:nbServiceStation-1
%             F=F+x(i)*invCost(ii);
%             i=i+1;
%         end
%         Income=Price(k)*ones(1,nbServiceStation);
%         for ii=1:nbServiceStation
%             F=F-x(i)*Income(ii);
%             i=i+1;
%         end
%     end
% end
HandleCost_new=VarX1;
for t=1:nbTrain
    nbServiceStation=max(TrainLine(t,:));
    for ii=1:nbServiceStation
        F1=F1+HandlingCost(HandlingTime{t}(ii),VarX1{t}(ii),Congestion{t}(ii),HandleCapacity{t}(ii),Alpha,Belta,VOT,KKK);
        HandleCost=HandleCost+HandlingCost(HandlingTime{t}(ii),VarX1{t}(ii),Congestion{t}(ii),HandleCapacity{t}(ii),Alpha,Belta,VOT,KKK);
        HandleCost_new{t}(ii)=HCEA_dev_HandlingCost(HandlingTime{t}(ii),VarX1{t}(ii),Congestion{t}(ii),HandleCapacity{t}(ii),Alpha,Belta,VOT,KKK);
    end
end
end
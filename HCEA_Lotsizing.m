function [FV,xx2,HandleCost]=  HCEA_Lotsizing(xx1,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
%% Parameter setting
[nbCenter,nbStation]=size(DCRSMatrix);
[nbTrain,~]=size(TrainLine);
[nbKind,~]=size(FixedCost);

%% Building up constraints
[NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint] = HCEA_Constraints(TrainCapacity,DCRSMatrix,TrainLine,FixedCost,Demand);

%% ===== GA Main loop =====
COND =1;
iter =0;
number_of_population=500;
probablity_initial=0.5*ones(1,nbKind*nbCenter);
%probablity_initial=1*ones(1,nbKind*nbCenter);
%probablity_initial=[1,1,1,0,0,0];
probablity=0.5*ones(1,nbKind*nbCenter);
solution=0*ones(number_of_population,nbKind*nbCenter);
numberVariable=size(xx1,1);
a0=numberVariable/nbKind;
LB=0*ones(number_of_population,size(xx1,1));
UB=inf*ones(number_of_population,size(xx1,1));
FV=[];
X=[];
HC=[];
FV_curve=[];
X_curve=[];

while COND
    % 1 initialization
    for p=1:number_of_population
        if rand>=0.5
            for k=1:nbKind
                for c=1:nbCenter
                    if probablity((k-1)*nbCenter+c)>rand
                        LB(p,(k-1)*a0+c)=1;
                        solution(p,(k-1)*nbCenter+c)=1;
                        UB(p,(k-1)*a0+c)=1;
                    else
                        LB(p,(k-1)*a0+c)=0;
                        solution(p,(k-1)*nbCenter+c)=0;
                        UB(p,(k-1)*a0+c)=0;
                    end
                end
            end
        else
           for k=1:nbKind
                for c=1:nbCenter
                    if probablity_initial((k-1)*nbCenter+c)>rand
                        LB(p,(k-1)*a0+c)=1;
                        solution(p,(k-1)*nbCenter+c)=1;
                        UB(p,(k-1)*a0+c)=1;
                    else
                        LB(p,(k-1)*a0+c)=0;
                        solution(p,(k-1)*nbCenter+c)=0;
                        UB(p,(k-1)*a0+c)=0;
                    end                
                end
            end
        end
    end
   % F-W algorithm
   parfor ii=1:number_of_population % for every population 
      [x2,F,HandleCost] = HCEA_FW_algorithm(LB(ii,:),UB(ii,:),NonbindingConstraint,DemandConstraint,LBNonbindingConstraint,UBNonbindingConstraint,LBDemandConstraint,UBDemandConstraint,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK);
      FV=[FV,F];
      X=[X,x2];
      HC=[HC,HandleCost];
   end
   FV1=sortrows([FV;X;HC]',1);
   GEN_PRO=[];
   for k=1:nbKind
            generate_probablity=FV1(1:number_of_population/2,(k-1)*a0+2:(k-1)*a0+nbCenter+1);
            GEN_PRO=[GEN_PRO,generate_probablity];
   end
    probality1=sum(GEN_PRO)/(number_of_population/2);
    FV_curve=[FV_curve,FV1(1,1)];
    
    iter=iter+1;
    if iter==10;
        COND=0;
    end
    drawnow 
    plot(FV_curve)
end
xx2=FV1(1,2:size(FV1,2)-1);
HandleCost=FV1(1,size(FV1,2));
FV=FV_curve(10);
end


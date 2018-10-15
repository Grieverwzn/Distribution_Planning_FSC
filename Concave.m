function [TotalHandlingCost,MST]= Concave(TrainCapacity,DCRSMatrix,TrainLine,Belta,HandlingTime,VOT,Lambda,Congestion,HandleCapacity,KKK,Alpha);;
[nbTrain,nbStation]=size(TrainLine);
Upper=sum(TrainCapacity);
TotalHandlingCost=0;
MST=HandlingTime;
parfor t=1:nbTrain
    [~,nbIVStation]=size(HandlingTime{t});
    for s=1:nbIVStation
%--------------------用fmincon（牛顿法）求解----------------------------
        options = optimset('Algorithm','interior-point'); % run interior-point algorithm
        [M,FVAL,~,~]=fmincon(@(MM)Fmin(MM,Lambda{t}(s),HandlingTime{t}(s),Congestion{t}(s),HandleCapacity{t}(s),Alpha,Belta,VOT,KKK),0,[],[],[],[],0,Upper,[],options);
        TotalHandlingCost=TotalHandlingCost+FVAL;
        MST{t}(s)=M;
%--------------------不用fmincon（牛顿法）求解----------------------------
%        Numberator=Lambda{t}(s)*((HandleCapacity{t}(s))^(Belta));
%        Denominator=(Belta+1)*VOT*HandlingTime{t}(s)*Congestion{t}(s);
%        Stationary=(1/KK)*(Numberator/Denominator)^(1/Belta);
%        %Fmin(MM,Lambda{t}(s),HandlingTime{t}(s),Congestion{t}(s),HandleCapacity{t}(s),Belta,VOT,KK)
%        KK1=Fmin(Stationary,Lambda{t}(s),HandlingTime{t}(s),Congestion{t}(s),HandleCapacity{t}(s),Belta,VOT,KK);
%        KK2=Fmin(Upper,Lambda{t}(s),HandlingTime{t}(s),Congestion{t}(s),HandleCapacity{t}(s),Belta,VOT,KK);
%        KK3=0;
%        [minValue,xxx]=min([KK1,KK2,KK3]);
%         if xxx==1
%             MST{t}(s)=Stationary;
%             TotalHandlingCost=TotalHandlingCost+KK1;
%         elseif xxx==2
%             MST{t}(s)= Upper;
%             TotalHandlingCost=TotalHandlingCost+KK2;
%         elseif xxx==3
%             MST{t}(s)= 0;
%             TotalHandlingCost=TotalHandlingCost+KK3;
%         end
    end
end
end



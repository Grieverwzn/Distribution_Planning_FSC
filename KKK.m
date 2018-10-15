function [TotalHandlingCost,MST] = KKK()
Lambda=30;
HandlingCost=0;
TT=[];
for i=1:200
HandlingCost=HandlingCost+0.1;
Belta=2;
Stationary=(Lambda/(HandlingCost*Belta))^(1/(Belta-1));
Upper=300;
Lower=0;
KK1=HandlingCost*(Stationary)^Belta-Lambda*(Stationary);
KK2=HandlingCost*( Upper)^Belta-Lambda*( Upper);
KK3=0;
[minValue,xxx]=min([KK1,KK2,KK3]);
if xxx==1
            MST=Stationary;
            TotalHandlingCost=KK1;
elseif xxx==2
            MST= Upper;
            TotalHandlingCost=KK2;
elseif xxx==3
            MST= 0;
            TotalHandlingCost=KK3;
end
TT=[TT,TotalHandlingCost];
end
end


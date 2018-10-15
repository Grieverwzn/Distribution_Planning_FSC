function HC= GA_dev_HandlingCost(HandlingTime,VarX1,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK)
%HC=VOT*(HandlingTime*VarX1*(1+Alpha*((KKK*VarX1+Congestion)/HandleCapacity)^Belta));
% HC1=VOT*(HandlingTime*(1+Alpha*((KKK*VarX1+Congestion)/HandleCapacity)^Belta));
% HC2=VOT*(HandlingTime*VarX1*(Alpha*Belta*KKK*((KKK*VarX1+Congestion)/HandleCapacity)^(Belta-1)));
% HC=HC1+HC2;
HC=VOT*HandlingTime*Alpha*Belta*KKK*((KKK*VarX1+Congestion)/HandleCapacity)^(Belta-1);
end
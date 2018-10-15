function HC= HandlingCost(HandlingTime,VarX1,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK)
HC=VOT*(HandlingTime*VarX1*(1+Alpha*((KKK*VarX1+Congestion)/HandleCapacity)^Belta));
end
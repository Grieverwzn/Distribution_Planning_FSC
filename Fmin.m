function f = Fmin(MM,Lambda,HandlingTime,Congestion,HandleCapacity,Alpha,Belta,VOT,KKK)
Coff=(VOT*HandlingTime*Alpha)/(HandleCapacity^Belta);
f=Coff*MM*(KKK*MM+Congestion)^Belta-Lambda*MM;
end


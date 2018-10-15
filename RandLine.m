
function [Line]=RandLine(nbStopDistr,nbStation) % Generate a train line
%% Generate the number of stops based on real data sets
nbStopDistr=ceil(nbStopDistr)-1;% in our model the numebr of stops can be reduced 
[pdf,~]=hist(nbStopDistr,max(nbStopDistr)-min(nbStopDistr)+1);% probability distribution function
% max(nbStopDistr): maximum number stops of a trip
% min(nbStopDistr): minimum number stops of a trip
normpdf=pdf./sum(pdf);%normalized pdf
for i=1:max(nbStopDistr)-min(nbStopDistr)+1 % totally we have "max(nbStopDistr)-min(nbStopDistr)+1" possible numbers of stops 
cdf(i)=sum(pdf(1:i));% transform pdf to cdf
normcdf(i)=sum(normpdf(1:i));% normalized cdf
nbStop_cdf(i)=i+min(nbStopDistr)-1;
end
nbtest=rand;% 
for i=1:max(nbStopDistr)-min(nbStopDistr)+1 % totally we have "max(nbStopDistr)-min(nbStopDistr)+1" possible numbers of stops 
if nbtest<=normcdf(i)
    nbStop=nbStop_cdf(i);
    break
end
end

%nbStop=5;

%% Generate random skip-stop pattern
Line=zeros(1,nbStation);
Label=zeros(1,nbStation);% label whether station is used in this line
COND=1;% condition number
while COND==1
    Stop=ceil(rand*nbStation);
    if Label(Stop)==0
        Label(Stop)=1;               
    end
    if sum (Label)==nbStop
    COND=0;
    end
end

%% Index the stations in the line 
index=1;
for i=1:nbStation
if Label(i)==1
Line(i)=index;
index=index+1;
end
end

end


function [KKK,Alpha,Belta,VOT,HandlingTime,HandleCapacity,Congestion,TrainCapacity,DCRSMatrix,TrainLine,FixedCost,VariableCost,InventoryCost,Price,Demand] = DataRand();
%% Parameters 
prompt = {'1.Beijing-Guanzhou 2."Beijing-Shanghai"+"Nanjing+Shanghai" 3.Personal data set'};
dlg_title = 'Choose the basic data set for random numerious tests';
num_lines = 1;
def = {'3'};
options.Resize='on';
value_i = inputdlg(prompt,dlg_title,num_lines,def,options);
opt1=str2double(value_i);

%--------------
if opt1==1
load('nbStopDistr(Beijing-Guanzhou)')% loading data set of Beijing-Guanzhou
nbStopDistr=ceil(nbStopDistr);
[nbtra,~]=size(nbStopDistr);
nbTrain=nbtra; % maximum number of  train
nbStation=36;% number of stations on Beijing Guanzhou high-speed line
end
%--------------
if opt1==2
load('nbStopDistr(Beijing-Shanghai)')% loading data set of Beijing-Guanzhou
nbStopDistr=ceil(nbStopDistr);
[nbtra,~]=size(nbStopDistr);
nbTrain=nbtra; % maximum number of  train
nbStation=31;% number of stations on Beijing Shanghai corridor (including Nanjing2Shanghai)
end
if opt1==3
title1 = 'Number of trains';
def1 = {'50'};
title2 = 'Number of stations';
def2 = {'50'};
title3 = 'LB of number of stops';
def3 = {'5'};
title4 = 'UB of number of stops';
def4 = {'10'};
nbTrain = inputdlg([],title1,num_lines,def1,options);
nbStation = inputdlg([],title2,num_lines,def2,options);
LB = inputdlg([],title3,num_lines,def3,options);
UB = inputdlg([],title4,num_lines,def4,options);
nbTrain=str2double(nbTrain);
nbStation=str2double(nbStation);
LB=str2double(LB);
UB=str2double(UB);
nbStopDistr=zeros(nbTrain,1);
for t=1:nbTrain
    nbStopDistr(t)=unifrnd(LB,UB);% uniform distribution
end
end

%--------------
nbDC=nbStation;% number of DCs
% We assume that nbStation=nbDC in our randomly generated numerous data set 
DCRSMatrix=eye(nbStation,nbStation); %Distribution Center to rail station assignment matrix



%% Generate a random line plan
TrainLine=zeros (nbTrain,nbStation);

for t=1:nbTrain
    [Line]=RandLine(nbStopDistr,nbStation);
    TrainLine (t,:)=Line;
end

%TrainCapacity=[300,400]*1; 
TrainCapacity=[150,250]*1;% 2018.11.20 Xin 
%TrainCapacity=[0,280]*1; 
%% Generate random fixed costs
% 第一行是cold chain; 第二行是ambient meals
% 每一列是一个Distribution Center

for d=1:nbDC
FixedCostType1(d)=unifrnd (800,900);
FixedCostType2(d)= unifrnd (50,150);
end
FixedCost=[FixedCostType1;FixedCostType2];

%% Generate random variable cost
VariableCost={};
for t=1:nbTrain
    nbStop=max(TrainLine(t,:));% count the number of stops
    variable_cost_type1=zeros(1,nbStop);
    variable_cost_type2=zeros(1,nbStop);
    for s=1:nbStop
        variable_cost_type1(s)=unifrnd (2,11);
        variable_cost_type2(s)=unifrnd (1,6);
    end
    variable_cost=[variable_cost_type1;variable_cost_type2];% for each train we have a variable cost
    VariableCost=[VariableCost; variable_cost];
end   

%% 产品与人的转化率(food product 2 person)
KKK=1/10;

%% GenerateBasic handling time per unit of products
HandlingTime={};
for t=1:nbTrain
    nbStop=max(TrainLine(t,:));% count the number of stops
    handling_time=zeros(1,nbStop);
    for s=1:nbStop
        handling_time(s)=unifrnd (0.1,5);% 2018.11.20 Xin
    end
   HandlingTime=[HandlingTime; handling_time];
end   

%%
% VOT
VOT=1;

%% Capacity and congestion
% 基础设施某一条流线上允许的最大客流“减去”当时该流线上的客流量 

HandleCapacity={};
Congestion={};
Demand={};
for t=1:nbTrain
    nbStop=max(TrainLine(t,:));% count the number of stops
    handling_capacity=zeros(1,nbStop);
    congestion=zeros(1,nbStop);
    demand=zeros(1,nbStop);
    for s=1:nbStop
        handling_capacity(s)=300;
        congestion(s)=unifrnd (250,300);
        demand(s)=ceil(unifrnd (180,180));
    end
   HandleCapacity=[HandleCapacity;handling_capacity];
   Congestion=[Congestion;congestion];
   Demand=[Demand;demand];
end   


Alpha=1.5;
% Reliability cofficient
Belta=4;

InventoryCost=[unifrnd(3,5) unifrnd(1,3)];
%Price=[65-5,49-4];
Price1=[unifrnd(50,70),unifrnd(30,50)]; % 2018.11.20 Xin
Price=Price1-InventoryCost;
end


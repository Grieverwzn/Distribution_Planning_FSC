function [CostConfig1,CostConfig2,Compare1,Compare2]=showed(x1,Objective1, xx1,  nbKind, nbCenter, TrainLine, nbTrain, nbStation, TotalHandCell1,TotalHandCell2, InventoryCost,ffv,fv2)   
%================= 显示结果 =============================
% nbCenter 城市数量/仓库数量
% nbStation 车站数量
% nbTrain 列车数量
% DCRS 城市车站关系
% TrainLine 列车停站方案
% FixedCost,VariableCost,InventoryCost,Price
%=======================================================
%load testcase0704.mat

%----------------- 数据分类整理 -------------------------
%...........................按产品划分..........................................
a0=size(x1,1)/nbKind;
% 固定成本(fixedc1 是考虑装卸成本情况下的Set-up cost；fixedc2 是不考虑装卸成本情况下的Set-up cost)
% 无论谁都需要用Objective1 原因是：只有它是没有修正过的Variable Cost（也就是Transporation Cost）
fixedc1=[Objective1(1,1:nbCenter).*x1(1:nbCenter,1)';Objective1(1,a0+1:a0+nbCenter).*x1(a0+1:a0+nbCenter,1)'];
fixedc2=[Objective1(1,1:nbCenter).*xx1(1:nbCenter,1)';Objective1(1,a0+1:a0+nbCenter).*xx1(a0+1:a0+nbCenter,1)'];
% 总固定成本
% fixedc=[Objective(1,1:nbCenter)*x1(1:nbCenter,1),...
%     Objective(1,a0+1:a0+nbCenter)*x1(a0+1:a0+nbCenter,1)];
% 各列车其他成本
a1=max(TrainLine')';
varc1=zeros(nbTrain,nbKind);
unsoldstoc1=zeros(nbTrain,nbKind);
soldstoc1=zeros(nbTrain,nbKind);
pric1=zeros(nbTrain,nbKind);
hanc1=zeros(nbTrain,1);
hanc2=zeros(nbTrain,1);
varc2=zeros(nbTrain,nbKind);
unsoldstoc2=zeros(nbTrain,nbKind);
soldstoc2=zeros(nbTrain,nbKind);
pric2=zeros(nbTrain,nbKind);

% 行是列车，列是产品
for i=1:nbTrain
    a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % 前面包含的变量数量
    varc1(i,:)=[Objective1(1,a2+1:a2+a1(i))*x1(a2+1:a2+a1(i),1),...
        Objective1(1,a0+a2+1:a0+a2+a1(i))*x1(a0+a2+1:a0+a2+a1(i),1)];
    unsoldstoc1(i,:)=[Objective1(1,a2+a1(i)+1:a2+2*a1(i)-1)*x1((a2+a1(i)+1:a2+2*a1(i)-1),1),...
        Objective1(1,a0+a2+a1(i)+1:a0+a2+2*a1(i)-1)*x1(a0+a2+a1(i)+1:a0+a2+2*a1(i)-1,1)];
    soldstoc1(i,:)=[(zeros(1,a1(i))+InventoryCost(1))*x1(a2+2*a1(i):a2+3*a1(i)-1,1),...
        (zeros(1,a1(i))+InventoryCost(2))*x1(a0+a2+2*a1(i):a0+a2+3*a1(i)-1,1)];
    pric1(i,:)=[(Objective1(1,a2+2*a1(i):a2+3*a1(i)-1)-InventoryCost(1))*x1(a2+2*a1(i):a2+3*a1(i)-1,1),...
        (Objective1(1,a0+a2+2*a1(i):a0+a2+3*a1(i)-1)-InventoryCost(2))*x1(a0+a2+2*a1(i):a0+a2+3*a1(i)-1,1)];
end
stoc1=soldstoc1+unsoldstoc1;

for t=1:nbTrain
    hanc1(t)= sum(TotalHandCell1{t});
end
% set-up cost/transporation cost/ storage cost/handling cost/ selling income
TotalPC1=sum(sum(fixedc1));
TotalTC1= sum(sum(varc1));
TotalSC1= sum(sum(stoc1));
TotalHC1= sum(hanc1);
TotalSI1= -sum(sum(pric1));
Profit1=TotalSI1-(TotalPC1+TotalTC1+TotalSC1+TotalHC1);
CostConfig1=[TotalPC1,TotalTC1,TotalSC1,TotalHC1];

%===================

for i=1:nbTrain
    a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % 前面包含的变量数量
    varc2(i,:)=[Objective1(1,a2+1:a2+a1(i))*xx1(a2+1:a2+a1(i),1),...
        Objective1(1,a0+a2+1:a0+a2+a1(i))*xx1(a0+a2+1:a0+a2+a1(i),1)];
    unsoldstoc2(i,:)=[Objective1(1,a2+a1(i)+1:a2+2*a1(i)-1)*xx1((a2+a1(i)+1:a2+2*a1(i)-1),1),...
        Objective1(1,a0+a2+a1(i)+1:a0+a2+2*a1(i)-1)*xx1(a0+a2+a1(i)+1:a0+a2+2*a1(i)-1,1)];
    soldstoc2(i,:)=[(zeros(1,a1(i))+InventoryCost(1))*xx1(a2+2*a1(i):a2+3*a1(i)-1,1),...
        (zeros(1,a1(i))+InventoryCost(2))*xx1(a0+a2+2*a1(i):a0+a2+3*a1(i)-1,1)];
    pric2(i,:)=[(Objective1(1,a2+2*a1(i):a2+3*a1(i)-1)-InventoryCost(1))*xx1(a2+2*a1(i):a2+3*a1(i)-1,1),...
        (Objective1(1,a0+a2+2*a1(i):a0+a2+3*a1(i)-1)-InventoryCost(2))*xx1(a0+a2+2*a1(i):a0+a2+3*a1(i)-1,1)];
end
stoc2=soldstoc2+unsoldstoc2;
for t=1:nbTrain
    hanc2(t)= sum(TotalHandCell2{t});
end
TotalPC2=sum(sum(fixedc2));
TotalTC2= sum(sum(varc2));
TotalSC2= sum(sum(stoc2));
TotalHC2= sum(hanc2);
TotalSI2= -sum(sum(pric2));
Profit2=TotalSI2-(TotalPC2+TotalTC2+TotalSC2+TotalHC2);
CostConfig2=[TotalPC2,TotalTC2,TotalSC2,TotalHC2];
Compare1=[CostConfig1;CostConfig2]';
Compare2=[TotalSI1,Profit1;TotalSI2,Profit2]';

%=============（考虑装卸)计算上可行解===============================


% ....分车、站统计各运输量，存储量，销售量....................
 varn11=zeros(nbTrain,nbStation);
 ston11=zeros(nbTrain,nbStation);
 prin11=zeros(nbTrain,nbStation);
 varn21=zeros(nbTrain,nbStation);
 ston21=zeros(nbTrain,nbStation);
 prin21=zeros(nbTrain,nbStation);
 
 for i=1:nbTrain
     a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % 前面包含的变量数量
     for j=1:a1(i)
         a3=find(TrainLine(i,:)==j);
         varn11(i,a3)=x1(a2+j,1);
         varn21(i,a3)=x1(a0+a2+j,1);
         prin11(i,a3)=x1(a2+2*a1(i)+j-1,1);
         prin21(i,a3)=x1(a0+a2+2*a1(i)+j-1,1);
         if j<a1(i)
             ston11(i,a3)=x1(a2+a1(i)+j,1);
             ston21(i,a3)=x1(a0+a2+a1(i)+j,1);
         end
     end
 end
 
%....(不考虑装卸)分车、站统计各运输量，存储量，销售量....................
 varn12=zeros(nbTrain,nbStation);
 ston12=zeros(nbTrain,nbStation);
 prin12=zeros(nbTrain,nbStation);
 varn22=zeros(nbTrain,nbStation);
 ston22=zeros(nbTrain,nbStation);
 prin22=zeros(nbTrain,nbStation);
 
 for i=1:nbTrain
     a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % 前面包含的变量数量
     for j=1:a1(i)
         a3=find(TrainLine(i,:)==j);
         varn12(i,a3)=xx1(a2+j,1);
         varn22(i,a3)=xx1(a0+a2+j,1);
         prin12(i,a3)=xx1(a2+2*a1(i)+j-1,1);
         prin22(i,a3)=xx1(a0+a2+2*a1(i)+j-1,1);
         if j<a1(i)
             ston12(i,a3)=xx1(a2+a1(i)+j,1);
             ston22(i,a3)=xx1(a0+a2+a1(i)+j,1);
         end
     end
 end


%  
%  
% 
KKK=nbTrain;
 %----------------- 绘图 ---------------------------------

 %..... 各类成本 分车统计 .................................
 figure(2);
 subplot(5,1,1);bar(fixedc1');
 %set(gca,'xtick',1:1:nbCenter,'XTickLabel',centername,'fontsize',6);
 %title('仓库各类产品成本/元','fontsize',10);
 title('Set-up cost/Yuan','fontsize',10);
 hold on
 subplot(5,1,2);bar(varc1(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Transporation cost/Yuan','fontsize',10);
  subplot(5,1,3);bar(hanc1(1:KKK));
 title('Handling cost/Yuan','fontsize',10);
  %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
  subplot(5,1,4);bar(stoc1(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Storage cost/Yuan','fontsize',10);
 subplot(5,1,5);bar(-pric1(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Income/Yuan','fontsize',10);

 hold on
%  
%  %..... 各类成本 分车统计 .................................
 figure(3);
 subplot(5,1,1);bar(fixedc2');
 %set(gca,'xtick',1:1:nbCenter,'XTickLabel',centername,'fontsize',6);
 title('Set-up cost/Yuan','fontsize',10);
 hold on
 subplot(5,1,2);bar(varc2(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Transporation cost/Yuan','fontsize',10);
 subplot(5,1,3);bar(hanc2(1:KKK));
 title('Handling cost/Yuan','fontsize',10);
 subplot(5,1,4);bar(stoc2(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Storage cost/Yuan','fontsize',10);
 subplot(5,1,5);bar(-pric2(1:KKK,:));
 %set(gca,'xtick',1:1:KKK,'XTickLabel',trainname,'fontsize',6);
 title('Income/Yuan','fontsize',10);
 hold on

% 
% 
%  
 %.....各站的总量.........................................
 var_sta=[sum(varn11);sum(varn21)];
 sto_sta=[sum(ston11);sum(ston21)];
 pri_sta=[sum(prin11);sum(prin21)];
%  
%  %..... 各类成本 分车统计  .................................
%  figure(4);
%  subplot(3,1,1);bar3(varn11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车配送量情况','fontsize',10);
%  subplot(3,1,2);bar3(ston11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车存储量情况','fontsize',10);
%  subplot(3,1,3);bar3(prin11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车销售量情况','fontsize',10);
%  hold on
%   %..... 各类成本 分车统计  .................................
%  figure(5);
%  subplot(3,1,1);bar3(varn21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车配送量情况','fontsize',10);
%  subplot(3,1,2);bar3(ston21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车存储量情况','fontsize',10);
%  subplot(3,1,3);bar3(prin21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品1各车销售量情况','fontsize',10);
%  hold on
%  
%  
%   %..... 各类成本 分车统计  .................................
%  figure(6);
%  subplot(3,1,1);bar3(varn12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车配送量情况','fontsize',10);
%  subplot(3,1,2);bar3(ston12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车存储量情况','fontsize',10);
%  subplot(3,1,3);bar3(prin12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车销售量情况','fontsize',10);
%  hold on
%   %..... 各类成本 分车统计  .................................
%  figure(7);
%  subplot(3,1,1);bar3(varn22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车配送量情况','fontsize',10);
%  subplot(3,1,2);bar3(ston22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车存储量情况','fontsize',10);
%  subplot(3,1,3);bar3(prin22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('产品2各车销售量情况','fontsize',10);
%  hold on
end 



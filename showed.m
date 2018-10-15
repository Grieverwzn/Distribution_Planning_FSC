function [CostConfig1,CostConfig2,Compare1,Compare2]=showed(x1,Objective1, xx1,  nbKind, nbCenter, TrainLine, nbTrain, nbStation, TotalHandCell1,TotalHandCell2, InventoryCost,ffv,fv2)   
%================= ��ʾ��� =============================
% nbCenter ��������/�ֿ�����
% nbStation ��վ����
% nbTrain �г�����
% DCRS ���г�վ��ϵ
% TrainLine �г�ͣվ����
% FixedCost,VariableCost,InventoryCost,Price
%=======================================================
%load testcase0704.mat

%----------------- ���ݷ������� -------------------------
%...........................����Ʒ����..........................................
a0=size(x1,1)/nbKind;
% �̶��ɱ�(fixedc1 �ǿ���װж�ɱ�����µ�Set-up cost��fixedc2 �ǲ�����װж�ɱ�����µ�Set-up cost)
% ����˭����Ҫ��Objective1 ԭ���ǣ�ֻ������û����������Variable Cost��Ҳ����Transporation Cost��
fixedc1=[Objective1(1,1:nbCenter).*x1(1:nbCenter,1)';Objective1(1,a0+1:a0+nbCenter).*x1(a0+1:a0+nbCenter,1)'];
fixedc2=[Objective1(1,1:nbCenter).*xx1(1:nbCenter,1)';Objective1(1,a0+1:a0+nbCenter).*xx1(a0+1:a0+nbCenter,1)'];
% �̶ܹ��ɱ�
% fixedc=[Objective(1,1:nbCenter)*x1(1:nbCenter,1),...
%     Objective(1,a0+1:a0+nbCenter)*x1(a0+1:a0+nbCenter,1)];
% ���г������ɱ�
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

% �����г������ǲ�Ʒ
for i=1:nbTrain
    a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % ǰ������ı�������
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
    a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % ǰ������ı�������
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

%=============������װж)�����Ͽ��н�===============================


% ....�ֳ���վͳ�Ƹ����������洢����������....................
 varn11=zeros(nbTrain,nbStation);
 ston11=zeros(nbTrain,nbStation);
 prin11=zeros(nbTrain,nbStation);
 varn21=zeros(nbTrain,nbStation);
 ston21=zeros(nbTrain,nbStation);
 prin21=zeros(nbTrain,nbStation);
 
 for i=1:nbTrain
     a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % ǰ������ı�������
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
 
%....(������װж)�ֳ���վͳ�Ƹ����������洢����������....................
 varn12=zeros(nbTrain,nbStation);
 ston12=zeros(nbTrain,nbStation);
 prin12=zeros(nbTrain,nbStation);
 varn22=zeros(nbTrain,nbStation);
 ston22=zeros(nbTrain,nbStation);
 prin22=zeros(nbTrain,nbStation);
 
 for i=1:nbTrain
     a2=max(3*sum(a1(1:i-1))-i+1,0)+nbCenter; % ǰ������ı�������
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
 %----------------- ��ͼ ---------------------------------

 %..... ����ɱ� �ֳ�ͳ�� .................................
 figure(2);
 subplot(5,1,1);bar(fixedc1');
 %set(gca,'xtick',1:1:nbCenter,'XTickLabel',centername,'fontsize',6);
 %title('�ֿ�����Ʒ�ɱ�/Ԫ','fontsize',10);
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
%  %..... ����ɱ� �ֳ�ͳ�� .................................
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
 %.....��վ������.........................................
 var_sta=[sum(varn11);sum(varn21)];
 sto_sta=[sum(ston11);sum(ston21)];
 pri_sta=[sum(prin11);sum(prin21)];
%  
%  %..... ����ɱ� �ֳ�ͳ��  .................................
%  figure(4);
%  subplot(3,1,1);bar3(varn11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�������������','fontsize',10);
%  subplot(3,1,2);bar3(ston11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�����洢�����','fontsize',10);
%  subplot(3,1,3);bar3(prin11(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�������������','fontsize',10);
%  hold on
%   %..... ����ɱ� �ֳ�ͳ��  .................................
%  figure(5);
%  subplot(3,1,1);bar3(varn21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�������������','fontsize',10);
%  subplot(3,1,2);bar3(ston21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�����洢�����','fontsize',10);
%  subplot(3,1,3);bar3(prin21(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ1�������������','fontsize',10);
%  hold on
%  
%  
%   %..... ����ɱ� �ֳ�ͳ��  .................................
%  figure(6);
%  subplot(3,1,1);bar3(varn12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�������������','fontsize',10);
%  subplot(3,1,2);bar3(ston12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�����洢�����','fontsize',10);
%  subplot(3,1,3);bar3(prin12(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�������������','fontsize',10);
%  hold on
%   %..... ����ɱ� �ֳ�ͳ��  .................................
%  figure(7);
%  subplot(3,1,1);bar3(varn22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�������������','fontsize',10);
%  subplot(3,1,2);bar3(ston22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�����洢�����','fontsize',10);
%  subplot(3,1,3);bar3(prin22(1:KKK,:)');
%  %set(gca,'ytick',1:1:nbStation,'YTickLabel',stationname,'fontsize',6);
%  title('��Ʒ2�������������','fontsize',10);
%  hold on
end 



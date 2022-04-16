function [stands,C,coeff,pval] = correlated()
stands=load('stands.mat');
C=load('./stand_S.mat');
stands=stands.stand_S;
C=C.stand_S;
[coeff,pval]=corr(stands,C);

figure,
fig = gcf;
set(fig,'InvertHardCopy','off','color','white');
mdl = fitlm(C, stands);
h = plotAdded(mdl);
set(h(1),'Marker','.');
xlabel('Ŀ�������������');
ylabel('��������������');
title(sprintf('��pֵ = %g�µ���������ͼ', pval));

end
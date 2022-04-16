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
xlabel('目标城市历年数据');
ylabel('塞罕坝历年数据');
title(sprintf('当p值 = %g下的相关性拟合图', pval));

end
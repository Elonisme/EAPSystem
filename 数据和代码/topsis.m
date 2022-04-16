clc
clear
close all
load data_water_quality.mat
%%  �ڶ������ж��Ƿ���Ҫ����
[n,~] = size(X);
%% �������������򻯺�ľ�����б�׼��
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
%% ���û��ж��Ƿ���Ҫ����Ȩ��
weight = Entropy_Method(Z);
%% ���Ĳ������������ֵ�ľ������Сֵ�ľ��룬������÷�
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ �����ֵ�ľ�������
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- ����Сֵ�ľ�������
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
% disp('���ĵ÷�Ϊ��')
stand_S = S / sum(S);
[sorted_S,index] = sort(stand_S ,'descend');
essorder=[1:20]';
result = [essorder index stand_S];
result = sortrows(result,2);
A=result(:,1);
B=result(:,2);
C=result(:,3);
R=[A B C];
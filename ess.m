[file,path] = uigetfile({'*.xlsx';'*.xls'},'File Selector');
filepath=strcat(path,file);
Data = readtable(filepath);
Place = Data(:,1);
Place =table2array(Place);
lY = Place;
Y = categorical(Place);
Y = reordercats(Y,Place);
Datasize=size(Data);
Data =Data(:,2:Datasize(2));
Data = table2array(Data);
X=Data;
%%  �ڶ������ж��Ƿ���Ҫ����
[n,~] = size(X);
X = Min2Max(X);
%% �������������򻯺�ľ�����б�׼��
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
%% ���û��ж��Ƿ���Ҫ����Ȩ��
weight = Entropy_Method(Z);
%% ���Ĳ������������ֵ�ľ������Сֵ�ľ��룬������÷�
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ �����ֵ�ľ�������
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- ����Сֵ�ľ�������
S = D_N ./ (D_P+D_N);    % δ��һ���ĵ÷�
% disp('���ĵ÷�Ϊ��')
stand_S = S / sum(S)+0.01;
bar(Y,stand_S);
[~,index] = sort(stand_S);

nX=stand_S(index);
nX = num2str(nX);
nY=lY(index);
nY = string(nY);
XY = [nY nX];
% XY =array2table(XY);
%
%             [~,index] = sort(stand_S);
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
%%  第二步：判断是否需要正向化
[n,~] = size(X);
X = Min2Max(X);
%% 第三步：对正向化后的矩阵进行标准化
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
%% 让用户判断是否需要增加权重
weight = Entropy_Method(Z);
%% 第四步：计算与最大值的距离和最小值的距离，并算出得分
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weight,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P+D_N);    % 未归一化的得分
% disp('最后的得分为：')
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
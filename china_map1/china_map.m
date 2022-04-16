%-- ��ʡ�й���ͼ��MATLAB�еĻ��� --%
% Author: gaospecial@gmail.com
% Date: 2012-6-5 14:04:01
% ��ͼ������Դ�����һ���������Ϣϵͳ��վ
% �˿�������Դ������ͳ�����2011��
%% �����ͼ����
% �����ʡ�Ķ��������
sheng=shaperead('maps/bou2_4p.shp', 'UseGeoCoords', true);% ʡ
% ������ݷ�����������Ϊ���룬�����������ַ���������ģ���Ҫ�����ļ�����ʱ���ֵ�����
% �������Ƽ�¼����Ӧ��dbf�ļ��У�����ʹ��Excel�򿪣����Ҳ���������룬��ȡ���е����ı���Ϊ�ı��ļ�
% Ȼ���ڵ��빤�����������䱣��Ϊ*.mat��ʽ�ļ���������ȡ��
% �����滻sheng�����е����롾���Ǳ�֮ͨ������˭֪�����õķ���һ��������Ŷ��
load chinese_name.mat % ʡ��ʡ�ᣬ��Ҫ���е���ȷ����
for i=1:length(sheng)
    sheng(i).NAME=sheng_chinese_name{i}; % ����������ʾ����
end
unique(sheng_chinese_name) % ����34��ʡ��ֱϽ�У�������
length(sheng) % ����Ϊ925������
%% ʹ��importdata�򵼵���2011��ȫ��31��ʡ���˿�����
% dataΪ�˿���Ŀ textdataΪʡ����
d=importdata('renkou.txt');
data=d.data; % �˿���Ŀ
textdata=d.textdata; % ���Ӧ��ʡ������
%% �����ͼ����
% ��Բ�ͬʡ�ݣ��ֱ����ò�ͬ����ɫ��FaceColor��
% ������ɫ
k=128;  
mycolormap=summer(k);
% ���ɲ�ͬ���򰴴�С����ɫ�������˿���Ŀ���ٷֱ�ָ����ͬ����ɫ
% �˿�Խ�࣬��ɫԽͻ��
geoname={sheng.NAME}';
max_data = max(data);
n=length(data);
mysymbolspec=cell(1,n); % Ԥ����������Լӿ촦���ٶ�
for i=1:n
    count=data(i);
    mycoloridx=floor( k * count / max_data );
    mycoloridx(mycoloridx<1)=1;
    myprovince=textdata{i};
    geoidx=strmatch(myprovince, geoname);
    if numel(geoidx) > 0
        province_name=geoname( geoidx(1) );
        mysymbolspec{i} = {'NAME', char(province_name), 'FaceColor', mycolormap( mycoloridx, :) };
    end
end
%% ��ʾ��ͼ
figure
ax=worldmap('china'); % ʹ��worldmap����������ͼ
setm(ax,'grid','off') % �ر�grid
setm(ax,'frame','off') % �رձ߿�
setm(ax,'parallellabel','off') % �ر���������
setm(ax,'meridianlabel','off') % �ر���������

% ��ؼ����������
symbols=makesymbolspec('Polygon',{'default','FaceColor',[0.9 0.9 0.8],...
    'LineStyle','--','LineWidth',0.2,...
    'EdgeColor',[0.8 0.9 0.9]},...
    mysymbolspec{:}...
    );
geoshow(sheng,'SymbolSpec',symbols); % �˴���mapshowͶӰ�᲻��ȷ

%% ͼ�ı�ע
% ��ͼ���Ҳ���ʾbar
colormap(summer(k))
hcb=colorbar('EastOutside');
step=round(max_data/11);
set(hcb,'YTick',(0:.1:1))
set(hcb,'YTickLabel',num2cell(0:step:max_data))

% ��ͼ��ӱ���
title('�й�2011���ʡ�˿��������ˣ�')
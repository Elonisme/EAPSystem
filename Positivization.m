

function [posit_x] = Positivization(x,type,i)
    if type == 1  %��С��
        disp(['��' num2str(i) '���Ǽ�С�ͣ���������'] )
        posit_x = Min2Max(x);  %����Min2Max����������
        disp(['��' num2str(i) '�м�С�����򻯴������'] )
        disp('~~~~~~~~~~~~~~~~~~~~�ֽ���~~~~~~~~~~~~~~~~~~~~')
    elseif type == 2  %�м���
        disp(['��' num2str(i) '�����м���'] )
        best = input('��������ѵ���һ��ֵ�� ');
        posit_x = Mid2Max(x,best);
        disp(['��' num2str(i) '���м������򻯴������'] )
        disp('~~~~~~~~~~~~~~~~~~~~�ֽ���~~~~~~~~~~~~~~~~~~~~')
    elseif type == 3  %������
        disp(['��' num2str(i) '����������'] )
        a = input('������������½磺 ');
        b = input('������������Ͻ磺 '); 
        posit_x = Inter2Max(x,a,b);
        disp(['��' num2str(i) '�����������򻯴������'] )
        disp('~~~~~~~~~~~~~~~~~~~~�ֽ���~~~~~~~~~~~~~~~~~~~~')
    else
        disp('û���������͵�ָ�꣬����Type�������Ƿ��г���1��2��3֮�������ֵ')
    end
end

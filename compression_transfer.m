%����ת�ƾ���E1��E2
function [E1,E2]=compression_transfer(MPS_B,variable_x)


N=length(MPS_B);
MPS_X=cell(N,1);
%A��B������ͼcompression1
%A��B��������һ��
for n=1:N
    if n==variable_x
        MPS_X{n}=MPS_B{variable_x};
    else
       
        tensors={MPS_B{n},MPS_B{n}};
        legs={[-1 1 -2],[-3 1 -4]};
        seq=[1];
        finalOrder=[-1 -2 -3 -4];
        MPS_X{n}=ncon(tensors,legs,seq,finalOrder);   
    end

end

%���õ�λ����;�������������
Accumulate_E1=reshape(eye(1),[1 1 1 1]);
%���
%�������������ͼcompression2
for n=1:variable_x-1
        tensors={Accumulate_E1,MPS_X{n}};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
       Accumulate_E1=ncon(tensors,legs,seq,finalOrder);
end

E1=Accumulate_E1;
[d1,d2,d3,d4]=size(E1);
E1=reshape(E1,[d1*d2,d3*d4]);

%�ұ�
%���ҵ���ͼcompression_knownframe1
Accumulate_E2=reshape(eye(1),[1 1 1 1]);
for n=1:N-variable_x
        tensors={MPS_X{N-n+1},Accumulate_E2};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_E2=ncon(tensors,legs,seq,finalOrder);
end
E2=Accumulate_E2;
[d1,d2,d3,d4]=size(E2);
E2=reshape(E2,[d1*d2,d3*d4]);



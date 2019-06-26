%������
%%2018/3/32���淶�汾��left_canonicalMPS�汾����չ�汾
%������ƣ��м�汾��������MPS����ά�Ȳ�һ�������ϡ�
%Dimension ����ά��
function [MPS_X,S]=right_canonical(MPS_X)

N=length(MPS_X);

for n=1:N
[left_dim,Dimension,right_dim]=size(MPS_X{N-n+1,1});
tensor_A=reshape(MPS_X{N-n+1,1},[left_dim,right_dim*Dimension]);
[U,S,V]=svd(tensor_A,'econ');
V=V';
[dim_a,dim_b]=size(V);
V=reshape(V,[dim_a,Dimension,dim_b/Dimension]);
MPS_X{N-n+1,1}=V;

if n<=N-1

tensors={MPS_X{N-n,1},U,S};
legs={[-1 -2 1],[1 2],[2 -3]};
seq=[1 2];
finalOrder=[-1 -2 -3];
MPS_X{N-n,1}=ncon(tensors,legs,seq,finalOrder);%ͼright_canonical
end

end



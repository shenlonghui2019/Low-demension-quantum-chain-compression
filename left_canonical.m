%2018/3/29�����򻯣��淶�汾��left_canonicalMPS�汾����չ�汾
%������ƣ��м�汾��������MPS����ά�Ȳ�һ�������ϡ�

%����ɺ�����Ŀ������һ��MPS���һ������MPS��
%Dimension����ά��
function [MPS_X,S]=left_canonical(MPS_X)

N=length(MPS_X);

for n=1:N
[left_dim,Dimension,right_dim]=size(MPS_X{n});
tensor_A=reshape(MPS_X{n},[left_dim*Dimension,right_dim]);
[U,S,V]=svd(tensor_A,'econ');
V=V';
[dim_a,dim_b]=size(U);
U=reshape(U,[dim_a/Dimension,Dimension,dim_b]);
MPS_X{n}=U;

if n<=N-1
   tensors={S,V,MPS_X{n+1}};
   legs={[-1 1],[1 2],[2 -2 -3]};
   seq=[1 2];
   finalOrder=[-1 -2 -3];
   MPS_X{n+1}=ncon(tensors,legs,seq,finalOrder);%ͼleft_canonicalMPS1
end

end



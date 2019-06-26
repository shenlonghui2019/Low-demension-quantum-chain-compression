%右正则化
%%2018/3/32，规范版本，left_canonicalMPS版本的扩展版本
%对于设计，中间版本，后续的MPS键的维度不一样随后加上。
%Dimension 物理维度
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
MPS_X{N-n,1}=ncon(tensors,legs,seq,finalOrder);%图right_canonical
end

end



%2018/3/29左正则化，规范版本，left_canonicalMPS版本的扩展版本
%对于设计，中间版本，后续的MPS键的维度不一样随后加上。

%打包成函数，目标输入一个MPS输出一个正则化MPS；
%Dimension物理维度
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
   MPS_X{n+1}=ncon(tensors,legs,seq,finalOrder);%图left_canonicalMPS1
end

end



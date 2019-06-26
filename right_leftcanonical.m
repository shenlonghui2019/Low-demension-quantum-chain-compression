%right_leftcanonical,�������
%����һ������K������n<=K�������򻯣�����n>K���������򻯣�
function [MPS_X,right_leftS]=right_leftcanonical(MPS_X,K)

N=length(MPS_X);

%���С�ڵ���K�Ĳ���
for n=1:K
[left_dim,Dimension,right_dim]=size(MPS_X{n});
tensor_A=reshape(MPS_X{n},[left_dim*Dimension,right_dim]);
[U,S,V]=svd(tensor_A,'econ');
V=V';

[dim_a,dim_b]=size(U);
U=reshape(U,[dim_a/Dimension,Dimension,dim_b]);
MPS_X{n}=U;

if n<=K-1
    
tensors={S,V,MPS_X{n+1}};
legs={[-1 1],[1 2],[2 -2 -3]};
seq=[1 2];
finalOrder=[-1 -2 -3];
MPS_X{n+1}=ncon(tensors,legs,seq,finalOrder);%ͼleft_canonicalMPS1

else
   left_S=S;
   left_V=V;
    
end

end


%�ұߴ���k�Ĳ���
for n=1:N-K
[left_dim,Dimension,right_dim]=size(MPS_X{N-n+1});
tensor_A=reshape(MPS_X{N-n+1},[left_dim,right_dim*Dimension]);
[U,S,V]=svd(tensor_A,'econ');
V=V';
[dim_a,dim_b]=size(V);
V=reshape(V,[dim_a,Dimension,dim_b/Dimension]);
MPS_X{N-n+1,1}=V;

if n<=N-K-1

tensors={MPS_X{N-n},U,S};
legs={[-1 -2 1],[1 2],[2 -3]};
seq=[1 2];
finalOrder=[-1 -2 -3];
MPS_X{N-n}=ncon(tensors,legs,seq,finalOrder);%ͼright_canonical

else

    right_U=U;
    right_S=S;
end
end

%���м�ĶԽǾ�����⣻
%left_rightcanonical
if K<N
    right_leftS=left_S*left_V*right_U*right_S;
else
    right_leftS=left_S*left_V;
end



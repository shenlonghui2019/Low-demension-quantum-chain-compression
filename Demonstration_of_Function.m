clc
clear
D1=30;
D=20;
N=10;
MPS_A=cell(N,1);
Physics_dim=4;

for n=1:N
if n==1
    MPS_A{n}=rand(1,Physics_dim,D1);
elseif n==N
    MPS_A{n}=rand(D1,Physics_dim,1);
else
    MPS_A{n}=rand(D1,Physics_dim,D1);
end
end

MPS_B=MPS_compression(MPS_A,D);
MPS_A=left_canonical(MPS_A);
error_compression=checkout_compression(MPS_A,MPS_B)
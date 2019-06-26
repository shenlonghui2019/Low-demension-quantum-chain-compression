function MPS_A=MPS_compression(MPS_A,D)

N=length(MPS_A);

Physics_dim=size(MPS_A{1},2);

MPS_B=cell(N,1);
M=1;



%构建MPS_B
for n=1:N
if n==1
    MPS_B{n}=rand(1,Physics_dim,D);
elseif n==N
    MPS_B{n}=rand(D,Physics_dim,1);
else
    MPS_B{n}=rand(D,Physics_dim,D);
end
end


 
 %正则化，归一化
 MPS_A=left_canonical(MPS_A);
 MPS_A=right_canonical(MPS_A);
 
 while (1)

for variable_x=1:N
    
[MPS_B,S]=right_leftcanonical(MPS_B,variable_x);
MPS_B=right_leftcompressionS(MPS_B,variable_x,S); 


Output_G=compression_knownframe(MPS_A,MPS_B,variable_x);
    
[E1,E2]=compression_transfer(MPS_B,variable_x);

EE1=inv(E1);
EE2=inv(E2);

%X=INV（E1）*G*inV(E2)
%图compression_knownframe3
   tensors={EE1,Output_G,EE2};
   legs={[-1 1],[1 -2 2],[2 -3]};
   seq=[1 2];
   finalOrder=[-1 -2 -3];
   MPS_B{variable_x}=ncon(tensors,legs,seq,finalOrder);

%  error_compression (variable_x)=checkout_compression(MPS_A,MPS_B);
end

if M==1
error_compression=checkout_compression(MPS_A,MPS_B);
end

M=M+1;

if error_compression<10^(-10)
   break
elseif M>3
      break
end

 end

 
 
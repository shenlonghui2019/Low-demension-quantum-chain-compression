%计算G，E1*X*E2=G
%X=INV（E1）*G*inV(E2)
 function Output_G=compression_knownframe(MPS_A,MPS_B,variable_x)


%函数正式部分
N=length(MPS_A);

%MPS_X=cell(N,1);

%A和B的缩并图compression1
%A和B缩并放在一起
for n=1:N
    if n==variable_x
        MPS_A{n}=MPS_A{variable_x};
    else
        
      
        tensors={MPS_A{n},MPS_B{n}};
      
        legs={[-1 1 -2],[-3 1 -4]};
        seq=[1];
        finalOrder=[-1 -2 -3 -4];
        MPS_A{n}=ncon(tensors,legs,seq,finalOrder);   
    end

end

%设置单位矩阵和矩阵缩并好运算
Accumulate_E1=reshape(eye(1),[1 1 1 1]);
%左边
%调节缩并相似项，图compression2
for n=1:variable_x-1
        tensors={Accumulate_E1,MPS_A{n}};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_E1=ncon(tensors,legs,seq,finalOrder);
end
E1=Accumulate_E1;
[d1,d2,d3,d4]=size(E1);
E1=reshape(E1,[d1*d2,d3*d4]);

%右边
%从右到左图compression_knownframe1
Accumulate_E2=reshape(eye(1),[1 1 1 1]);
for n=1:N-variable_x
        tensors={MPS_A{N-n+1},Accumulate_E2};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_E2=ncon(tensors,legs,seq,finalOrder);
end
E2=Accumulate_E2;
[d1,d2,d3,d4]=size(E2);
E2=reshape(E2,[d1*d2,d3*d4]);
% E2=E2*S;

%整体缩并

%图compression_knownframe3
tensors={E1,MPS_A{variable_x},E2};
legs={[1 -1],[1 -2 2],[2 -3]};
seq=[1 2];
finalOrder=[-1 -2 -3];
Output_G=ncon(tensors,legs,seq,finalOrder);
% size(E1)
% size(E2)
% size(Output_G)



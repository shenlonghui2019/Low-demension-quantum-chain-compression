%检验误差为A*A'-2A*B+B*B
%改变一个点后得到的对比检查A和B的大小相似度


function error_compression=checkout_compression(MPS_A,MPS_B)


N=length(MPS_A);
text_A=cell(N,1);
text_B=cell(N,1);
text_AB=cell(N,1);

%A*A'
%图compression1
for n =1:N
        tensors={MPS_A{n},MPS_A{n}};
        legs={[-1 1 -2],[-3 1 -4]};
        seq=[1];
        finalOrder=[-1 -2 -3 -4];
        text_A{n}=ncon(tensors,legs,seq,finalOrder);
end
%调节缩并相似项，图compression2
Accumulate_textA=text_A{1};
for n=1:N-1
        tensors={Accumulate_textA,text_A{n+1}};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_textA=ncon(tensors,legs,seq,finalOrder);
end


%B*B'
%图compression1
for n =1:N
        tensors={MPS_B{n},MPS_B{n}};
        legs={[-1 1 -2],[-3 1 -4]};
        seq=[1];
        finalOrder=[-1 -2 -3 -4];
        text_B{n}=ncon(tensors,legs,seq,finalOrder);
end
%调节缩并相似项，图compression2
Accumulate_textB=text_B{1};
for n=1:N-1
        tensors={Accumulate_textB,text_B{n+1}};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_textB=ncon(tensors,legs,seq,finalOrder);
end
%  Accumulate_textB=S*S*Accumulate_textB;

%A*B
%图compression1
for n =1:N
        tensors={MPS_A{n},MPS_B{n}};
        legs={[-1 1 -2],[-3 1 -4]};
        seq=[1];
        finalOrder=[-1 -2 -3 -4];
        text_AB{n}=ncon(tensors,legs,seq,finalOrder);
end
%调节缩并相似项，图compression2
Accumulate_textAB=text_AB{1};
for n=1:N-1
        tensors={Accumulate_textAB,text_AB{n+1}};
        legs={[-1 1 -3 2],[1 -2 2 -4]};
        seq=[1 2];
        finalOrder=[-1 -2 -3 -4];
        Accumulate_textAB=ncon(tensors,legs,seq,finalOrder);
end
%  Accumulate_textAB= Accumulate_textAB*S;

 error_compression=Accumulate_textB+ Accumulate_textA-2*Accumulate_textAB;



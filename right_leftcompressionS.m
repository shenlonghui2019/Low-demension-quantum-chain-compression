%����MPS���򻯣��ѵ�����Sֵ�ϲ���mps������
function MPS_X=right_leftcompressionS(MPS_X,k,S)
        tensors={MPS_X{k},S};
        legs={[-1 -2 1],[1 -3]};
        seq=[1];
        finalOrder=[-1 -2 -3];
        MPS_X{k}=ncon(tensors,legs,seq,finalOrder);
% ������ģ�壬�븴�ƴ��ļ����޸�
% ��ʼ����
R0=[1 0 0;0 1 0;0 0 1];
R0=R0*f_rot_mat([1,0,0],pi/6);  %��ʼ��̬
w0=[0;1;1];
X0=[0;0;0];
v0=[0;0;0];
% ���ý�����
solution=myode45_rgb(@diffFun,[0,8],X0,v0,R0,w0);
% ����������
rkt=rocket_type01; %����������ж���һ��
% �����Ӿ�����
Animation(rkt,solution)

function [dXdt,dvdt,dRdt,dwdt]=diffFun(t,X,v,R,w) 
% ��װ�������
    rkt=rocket_type01; %��������綨��һ��
    m=rkt.mass;
    J=rkt.inertia;
% �������
    %������
    [Fcrtl,Mcrtl]=controller(t,X,v,R,w,J,m,rkt);  
    %�Ŷ���
    [Fturb,Mturb]=disturb(t,X,v,R,w,J,m,rkt);
    %���
    F=Fcrtl+Fturb;
    M=Mcrtl+Mturb;
    %ֱ�Ӹ������루ע�ʹ������л���
    F=[0;0;0];
    M=[0;0;0];
% Ԥ����    
    wx=f_skewer(w);
% �˶�ѧ��ϵ�붯��ѧ��ϵ
    dXdt=v;
    dvdt=F/m;
    dRdt=R*wx;
    dwdt=J^-1*(wx*J*w+M);
end

% ����������
function [outF,outM]=controller(t,X,v,R,w,J,m,rkt)
% �ڴ˴���ӿ�����
    outF=0;
    outM=0;
end

% ����Ŷ�����
function [outF,outM]=disturb(t,X,v,R,w,J,m,rkt)
% �ڴ˴��������Ŷ�
    outF=0;
    outM=0;
end
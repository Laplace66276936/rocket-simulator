% 主函数模板，请复制此文件再修改
% 初始条件
R0=[1 0 0;0 1 0;0 0 1];
R0=R0*f_rot_mat([1,0,0],pi/6);  %初始姿态
w0=[0;1;1];
X0=[0;0;0];
v0=[0;0;0];
% 调用解算器
solution=myode45_rgb(@diffFun,[0,8],X0,v0,R0,w0);
% 载入火箭配置
rkt=rocket_type01; %必须与仿真中定义一致
% 调用视觉函数
Animation(rkt,solution)

function [dXdt,dvdt,dRdt,dwdt]=diffFun(t,X,v,R,w) 
% 加装火箭配置
    rkt=rocket_type01; %必须与外界定义一致
    m=rkt.mass;
    J=rkt.inertia;
% 外界输入
    %控制器
    [Fcrtl,Mcrtl]=controller(t,X,v,R,w,J,m,rkt);  
    %扰动项
    [Fturb,Mturb]=disturb(t,X,v,R,w,J,m,rkt);
    %输出
    F=Fcrtl+Fturb;
    M=Mcrtl+Mturb;
    %直接给出输入（注释此项以切换）
    F=[0;0;0];
    M=[0;0;0];
% 预计算    
    wx=f_skewer(w);
% 运动学关系与动力学关系
    dXdt=v;
    dvdt=F/m;
    dRdt=R*wx;
    dwdt=J^-1*(wx*J*w+M);
end

% 控制器函数
function [outF,outM]=controller(t,X,v,R,w,J,m,rkt)
% 在此处添加控制器
    outF=0;
    outM=0;
end

% 外界扰动函数
function [outF,outM]=disturb(t,X,v,R,w,J,m,rkt)
% 在此处添加外界扰动
    outF=0;
    outM=0;
end
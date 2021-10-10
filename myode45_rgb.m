% 刚体运动通用解算器（定步长4阶5步龙格-库塔法）
function solution=myode45_rgb(odefun,tspan,X0,v0,R0,w0)
% 仿真参数
    dt=0.013;
    n=fix((tspan(2)-tspan(1))/dt);
% 初始化全局变量
    global SPACE INPUT ITER
    %状态空间变量
    SPACE.t=zeros(1,n+1);SPACE.t(1)=tspan(1);
    SPACE.X=zeros(length(X0),n+1);SPACE.X(:,1)=X0;
    SPACE.v=zeros(length(v0),n+1);SPACE.v(:,1)=v0;
    SPACE.R=zeros([size(R0),n+1]);SPACE.R(:,:,1)=R0;
    SPACE.w=zeros(length(w0),n+1);SPACE.w(:,1)=w0;
    %输入空间变量
    INPUT.outF=zeros(3,n+1);
    INPUT.outM=zeros(3,n+1);
% 迭代计算（定步长4阶5步龙格-库塔法）
    t=SPACE.t; X=SPACE.X; v=SPACE.v; R=SPACE.R; w=SPACE.w;
    for i=1:n
        ITER=i;
        [k11,k12,k13,k14]=odefun(t(i),X(:,i),v(:,i),R(:,:,i),w(:,i));
        [k21,k22,k23,k24]=odefun(t(i)+dt/2,X(:,i)+dt/2*k11,v(:,i)+dt/2*k12,R(:,:,i)+dt/2*k13,w(:,i)+dt/2*k14);
        [k31,k32,k33,k34]=odefun(t(i)+dt/2,X(:,i)+dt/2*k21,v(:,i)+dt/2*k22,R(:,:,i)+dt/2*k23,w(:,i)+dt/2*k24);
        [k41,k42,k43,k44]=odefun(t(i)+dt,X(:,i)+dt*k31,v(:,i)+dt*k32,R(:,:,i)+dt*k33,w(:,i)+dt*k34);
        t(i+1)=t(i)+dt;                                 SPACE.t(i+1)=t(i+1);
        X(:,i+1)=X(:,i)+dt/6*(k11+2*k21+2*k31+k41);     SPACE.X(:,i+1)=X(:,i+1);
        v(:,i+1)=v(:,i)+dt/6*(k12+2*k22+2*k32+k42);     SPACE.v(:,i+1)=v(:,i+1);
        R(:,:,i+1)=R(:,:,i)+dt/6*(k13+2*k23+2*k33+k43); SPACE.R(:,:,i+1)=R(:,:,i+1);
        w(:,i+1)=w(:,i)+dt/6*(k14+2*k24+2*k34+k44);     SPACE.w(:,i+1)=w(:,i+1);
    end
 % 输出
    solution.t=t; solution.X=X; solution.v=v; solution.R=R; solution.w=w;
    solution.dt=dt;
end 
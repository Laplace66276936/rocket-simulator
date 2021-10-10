% 视觉函数
function Animation(rkt,solution)
global INPUT ITER
% 读取轨迹参数
    dt=solution.dt;
    t=solution.t;
    X=solution.X;
    R=solution.R;
% 图框初始化
    %图框配置
    viewLimit=viewLimitDetect(rkt);
    plot3(0,0,0);
    hold on; grid on; 
    view([1.8,1.2,0.9])
    set(gca,'XLim',[-viewLimit,viewLimit],'YLim',[-viewLimit,viewLimit],'ZLim',[-viewLimit,viewLimit]);
    %刚体图形句柄
    pmain=patch('Faces',rkt.faceNet,'Vertices',rkt.vertice,'facecolor',[1 0.4 0.5],'FaceAlpha',0.5);
    %轨迹句柄
    pPath=plot3(0,0,0,'color',[0.53,0.81,0.98],'linewidth',1.3);
    %喷口图形句柄
    if isfield(rkt.otherProp,'spout')
        spoutExist=1;
        pjet=plot3([0,0],[0,0],[0,0],'-r','linewidth',rkt.otherProp.spoutSize(2));
    else
        spoutExist=0;
    end
    
    hold off
% 动画生成
    for i=1:length(t)
    %火箭主体动画
        vertx=rkt.transAct(X(:,i),R(:,:,i));
        set(pmain,'Vertices',vertx);
        set(gca,'XLim',[X(1,i)-viewLimit,X(1,i)+viewLimit],'YLim',[X(2,i)-viewLimit,X(2,i)+viewLimit],...
            'ZLim',[X(3,i)-viewLimit,X(3,i)+viewLimit]);
    %喷口动画
    if spoutExist
        jetBodyLong=sqrt(norm(INPUT.outF(:,i))/rkt.otherProp.maxJetForce*rkt.otherProp.spoutSize(1))*2*(1+0.1*rand(1));
        jetBodyWidth=sqrt(norm(INPUT.outF(:,i))/rkt.otherProp.maxJetForce*rkt.otherProp.spoutSize(2))*1.5+1;
        jetBody=-R(:,:,i)*INPUT.outF(:,i)/norm(INPUT.outF(:,i))*jetBodyLong;
        jetHead=R(:,:,i)*rkt.otherProp.spout+X(:,i);
        jetEnd=jetHead+jetBody;
        set(pjet,'Xdata',[jetHead(1),jetEnd(1)],'Ydata',[jetHead(2),jetEnd(2)],'Zdata',[jetHead(3),jetEnd(3)],...
            'linewidth',jetBodyWidth);
    end
    %轨迹绘制
    maxDotNum=400;
    set(pPath,'XData',X(1,max(1,i-maxDotNum):i),'YData',X(2,max(1,i-maxDotNum):i),'ZData',X(3,max(1,i-maxDotNum):i))
    %帧间隔
        pause(dt*0.89)
    end
end

function vL=viewLimitDetect(rkt)
    xl=min(rkt.vertice(:,1));    xr=max(rkt.vertice(:,1));
    yl=min(rkt.vertice(:,2));    yr=max(rkt.vertice(:,2));
    zl=min(rkt.vertice(:,3));    zr=max(rkt.vertice(:,3));
    pl=min(min(xl,yl),zl);       pr=max(max(xr,yr),zr);
    vL=pr-pl;
end 
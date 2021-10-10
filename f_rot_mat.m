function output=f_rot_mat(axis,angle)

axis=axis./norm(axis);           %normlize
K=zeros(3,3);
K(2,3)=-axis(1);K(3,2)=axis(1);   %skewer matrix construction
K(1,3)=axis(2);K(3,1)=-axis(2);
K(1,2)=-axis(3);K(2,1)=axis(3);

I=eye(3,3);
t=angle;
R=I+K*sin(t)+K^2*(1-cos(t));  %exponential map: so(3)->SO(3) 
output=R;
end

%vector to skewer:
%[x;y;z]-->[0 -z y]
%          [z 0 -x]
%          [-y x 0]
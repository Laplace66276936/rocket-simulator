function sita=f_logmap(R)
% %old method
%     angle=acos(complex((trace(R)-1)/2));
%     if angle==0
%         axis=[0;0;0];   %no angle means no rotation, so no axis. def its 0
%     else
%         axis=[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];
%         if(norm(axis)<1e-6) %if singular
%             axis=[1;1;1];
%         end
%         axis=axis/norm(axis);
%     end
%     sita=-1*real(axis*angle);

% new method
    angle=acos(complex((trace(R)-1)/2));
    axis=[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];
    if (norm(axis)<1e-6) %if singular
        if abs(trace(R)-3)<1e-6
            axis=[0;0;1];   angle=0;
        else;if abs(trace(R)+1)<1e-6
                if norm(R-[1 0 0;0 -1 0;0 0 -1])<1e-6
                    axis=[1;0;0];   angle=pi;
                else;if norm(R-[-1 0 0;0 1 0;0 0 -1])<1e-6
                        axis=[0;1;0];   angle=pi;
                    else;if norm(R-[-1 0 0;0 -1 0;0 0 1])<1e-6
                            axis=[0;0;1];   angle=pi;
                        else
                            disp("wrong")
                        end
                    end
                end
             end
        end
    end
    axis=axis/norm(axis);
    sita=axis*real(angle);
end
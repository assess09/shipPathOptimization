%*************************************************************************%
% The EVALOBJ1 function evaluates example function #1                                          %
%                                                                                                                                %
% function objfunc= EvalObj1(x,npara,popsize)                                                          %
% Input:                                                                                                                      %
%    x- variables, matrix                                                                                              %
%    npara- number of the variables                                                                           %
%    popsize- population size                                                                                     %
% Output:                                                                                                                    %
%    objfunc- objective function value, vector                                                              %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function [objfunc]...
    = EvalObj1(popsize,TargetPoint,TargetRange,ObstacleNumber,...
    ObstaclePoint,ObstacleRange_e,P_Hor,P_Ver,cutvector,Sp,T)

%********************************************************************
% ����ġ & gamma �����ֱ�
    WeightObjFuncDist=0;        % �̵��Ÿ� �����Լ� ����ġ
    WeightObjFuncTime=1;        % �̵��ҿ�ð� �����Լ� ����ġ
    
    gamma_T=0;                 % �̵��ҿ�ð� �����Լ� mapping gamma
    
%********************************************************************









%************************************************************************%
%   �����Լ�(�۾ƾ� ���� ������)
    
    % ��꿡 ���̴� ��ĵ� �������� ����
%         objfunc=zeros(popsize,1);
%         objfuncTarget=zeros(popsize,1);
%         EachobjfuncObstacle=zeros(popsize,ObstacleNumber);
%         objfuncObstacle=zeros(popsize,1);
%         objfuncDistance=zeros(popsize,1);
%         objfuncTime=zeros(popsize,1);
        
        for i=1:popsize;
        
            % ��ǥ���� ������ �����ϴ� �����Լ� 
                if sqrt((P_Hor(i,cutvector(i))-TargetPoint(1))^2+...
                        (P_Ver(i,cutvector(i))-TargetPoint(2))^2)<=TargetRange;
                     objfuncTarget(i)=0;
                else
                     objfuncTarget(i)=inf;
                end

           % ��ֹ��� ������ ȸ���ϴ� �����Լ�
        
            for Ob=1:ObstacleNumber
                
                for k=1:cutvector(i);
                    if sqrt((ObstaclePoint(Ob,1)-P_Hor(i,k))^2+...
                        (ObstaclePoint(Ob,2)-P_Ver(i,k))^2)<=ObstacleRange_e(Ob);                                               %  
                             EachobjfuncObstacle(i,Ob)=inf;   
                        break;
                    else
                        EachobjfuncObstacle(i,Ob)=0;     
                    end                                                          %
                end
            end

            objfuncObstacle(i)=max(EachobjfuncObstacle(i,:));

    % ��ǥ�������� �̵��Ÿ� �����Լ�
            objfuncDistance(i)=sum(Sp(i,1:cutvector(i)));


    % ��ǥ�������� �̵��ҿ�ð� �����Լ�
            objfuncTime(i)=T(i)-gamma_T;


   



% ���� �����Լ�
            objfunc(i)=objfuncTarget(i)+objfuncObstacle(i)...
                +WeightObjFuncDist*objfuncDistance(i)+...
                WeightObjFuncTime*objfuncTime(i);



        end
% disp(objfuncDistance);
% disp(cutvector);
end


%*************************************************************************%
% The BSTATPOP function calculates the statistics of a population                           %
%                                                                                                                                %
% function [chrombest,xbest,objbest,fitbest,objave,gam]= bStatPop(pop,x,...           %
%                                                                                   objfunc,fitness,maxmin)       %
% Input:                                                                                                                      %
%    pop- population, matrix                                                                                        %
%    x- variables, matrix                                                                                              %
%    objfunc- objective function value, vector                                                              %
%    fitness- fitness, vector                                                                                         %
%    maxmin= -1 for minimization, 1 for maximization                                                   %
% Output:                                                                                                                    %
%    chrombest- best chromosome, vector                                                                %
%    xbest- variables of the best chromesome, vector                                               %
%    objbest- best objective function value                                                                 %
%    fitbest- fitness of the best chromesome                                                              %
%    objave- average objective function value                                                            %
%    gam- minimun of objfunc or -objfunc                                                                  %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
% % % function [chrombest,xbest,objbest,fitbest,objave,gam,cutbest]=...
% % %     bStatPop(pop,x,objfunc,fitness,maxmin,cutvector)

function [chrombest,xbest,objbest,fitbest,objave,gam,cutbest,index,...
    P_Hor_best,P_Ver_best,S_best,T_best]=...
    bStatPop(pop,x,objfunc,fitness,maxmin,cutvector,P_Hor,P_Ver,S,T)


if(maxmin == 1)
  [objbest, index]= max(objfunc);
  gam= min(objfunc); 
else
  [objbest, index]= min(objfunc);
  gam= min(-objfunc); 
end
chrombest= pop(index,:);
xbest= x(index,:);              %
fitbest= fitness(index);
objave= mean(objfunc);          %
cutbest=cutvector(index);   % �ֿ�� ��ü�� cut
S_best=S(index);            % �ֿ�� ��ü�� �̵��Ÿ�
P_Hor_best=P_Hor(index,:);  % �ֿ�� ��ü�� ���ι��� poiotion
P_Ver_best=P_Ver(index,:);  % �ֿ�� ��ü�� ���ι��� position
T_best=T(index);            % �ֿ�� ��ü�� �ҿ�ð�



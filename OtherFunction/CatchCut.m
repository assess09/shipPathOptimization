%************************************************************************
% cut ����ֱ� + cut������ �̵��Ÿ� + cut������ �ҿ�ð�
%************************************************************************


function [cutvector,S,T]...
    = CatchCut(npara,popsize,TargetPoint,TargetRange,P_Hor,P_Ver,Sp,Tu)





    for i= 1:popsize



        %********************************************************************%
                % ����Ʈ�� ��ǥ������ �ɸ��� ����Ʈ��ȣ cut�� ��� ��               %
                                                                                 %
                cut=1;                                                           %
                while sqrt((TargetPoint(1)-P_Hor(i,cut)).^2+...
                        (TargetPoint(2)-P_Ver(i,cut)).^2)>TargetRange;    %
                    if cut==npara;                                               %  
                        break;                                                   %
                    else                                                         %
                    cut=cut+1;                                                   %   
                    end                                                          %
                end
                cutvector(i)=cut;

                              %
        %********************************************************************%

        % cut ������ �̵��Ÿ�
            S(i,:)=sum(Sp(i,1:cutvector(i)));
        % cut ������ �ҿ�ð�
            T(i,:)=Tu*cutvector(i);

    end

end

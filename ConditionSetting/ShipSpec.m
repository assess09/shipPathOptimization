%************************************************************************%
% ���μ��� ���� ����                                   %
%************************************************************************%

function [m,Ac,Aw,Vs,Tu,T0,MaxLeftAngle,MaxRightAngle,g,breadth,draft,LWL]=ShipSpec

    
    %*********************************************************************
    % ������ ���μ��� ����
        m=                    2600;          % ����� [kg]
        draft=                0.472;         % ��� [m]
        breadth=              5;             % �� [m]
        LWL=                  5;             % [m]
        Vs=                   10;            % ���� ���� [m/s] (���輱���� 10m/s��)
        MaxLeftAngle_degree=  10;            % �ʴ� �ִ� �¼�ȸ�� [degree]
        MaxRightAngle_degree= 10;            % �ʴ� �ִ� �켱ȸ�� [degree]
        depthExtreme=         1;           % �ִ���� [m] (�մ��� �ִ���̸� �𸣰���)
        
        T0=         300;
%         T0=         150;        % ������ �� ���ð� [s]
                                % ���ð� �� ���� ���� �� ��� ã�� ����
                                % �ʹ� ũ�� ���ð������ɸ�
                                % ���� ������
        Tu=         1;          % ħ�θ� �����ϴ� ���� �ð� [s]
        g=9.81;                  % �߷°��ӵ� [m/s]
    %********************************************************************
        MaxLeftAngle_degree=  MaxLeftAngle_degree*Tu;            % �����ð� �� �ִ� �¼�ȸ�� [degree]
        MaxRightAngle_degree= MaxRightAngle_degree*Tu;            % �����ð� �� �ִ� �켱ȸ�� [degree]

MaxLeftAngle=           MaxLeftAngle_degree*pi/180;          % �����ð��� �ִ� �¼�ȸ�� [rad];
MaxRightAngle=          MaxRightAngle_degree*pi/180;        % �����ð��� �ִ� �켱ȸ�� [rad];
    % �Ǹ��� ������ ������ �������� ����
    Ac=breadth*draft;                   % ����Ʒ��κ��� ��������. �������� �������� ����
    Aw=breadth*(depthExtreme-draft);    % ���� ���κ��� ��������. 
    
   
end

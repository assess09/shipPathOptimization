                                                                    %
function [Vrc,Vrw,x_E,theta_s_S,theta_ic_S,theta_iw_S]=...
    DeriveVr(x,U_current_zeroSpeed,U_wind_zeroSpeed,Vs,CurrentAngle,WindAngle,Vc,Vw)

    %  ����������ǥ�迡���� ������Ʈ ��ȸ�� ��� [rad]
        x_E=cumsum(x,2);                   % ����������ǥ�迡���� ������Ʈ ��ȸ�� [rad]. 12�� ���� ����
    
        
        
    %*******************************************************************
        % Current�� �ӵ����� ������ ��ü������ǥ ������ ��ȯ
            theta_ic_E=CurrentAngle+pi;        % ����������ǥ���� Current�� �߻��� ���Ӻ����� ����
            theta_ic_S=theta_ic_E-x_E;         % ��ü������ǥ���� Current�� �߻��� ���Ӻ����� ����

        % Wind�� �ӵ����� ������ ��ü������ǥ ������ ��ȯ
            theta_iw_E=WindAngle+pi;            % ����������ǥ���� Wind�� �߻��� ���Ӻ����� ����
            theta_iw_S=theta_iw_E-x_E;          % ��ü������ǥ���� Wind�� �߻��� ���Ӻ����� ����
    %*******************************************************************
        
        
    %*******************************************************************
        % ��ü������ǥ�� �߷¹��� ���Ӻ��� ���� ����
            theta_s_S=asin(1/Vs*(U_current_zeroSpeed*sin(theta_ic_S)+...
                U_wind_zeroSpeed*sin(theta_iw_S)));
    %*******************************************************************

    % Vp�� �ӵ��� �����ϴ� ������ ������ Vr ���
      
        Vp=Vs.*cos(theta_s_S)+U_current_zeroSpeed.*cos(theta_ic_S)+...
            U_wind_zeroSpeed.*cos(theta_iw_S);    % ���� ��������� �ӵ����� ���

        u=Vp.*cos(x_E);      % ���� zero speed�� x���� �ӵ� ����
        v=Vp.*sin(x_E);      % ���� zero speed�� y���� �ӵ� ����
        u_c=Vc.*cos(x_E);    % current�� x���� �ӵ� ����
        v_c=Vc.*sin(x_E);    % current�� y���� �ӵ� ����
        u_w=Vw.*cos(x_E);    % current�� x���� �ӵ� ����
        v_w=Vw.*sin(x_E);    % current�� y���� �ӵ� ����
        
        Vrc=sqrt((u-u_c).^2+(v-v_c).^2);      % Vp�� �ӵ��� �����ϴ� ������
                                             % ������ current velocity ũ��
        Vrw=sqrt((u-u_w).^2+(v-v_w).^2);      % Vp�� �ӵ��� �����ϴ� ������
                                             % ������ wind velocity ũ��

    end



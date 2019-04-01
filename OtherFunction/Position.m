%% �߷¿� ���� ���Ӱ� environmental force (current force, wind force)�� �߻���
 % �ӵ��� �̿��� x(���� ���ఢ)�� ���� ����Ʈ ��ǥ


function [P_Hor,P_Ver,Sp,theta_s_S,Vp]=Position(npara,popsize,Vs,Tu,...
    Vrc,Vrw,m,Ac,Aw,rho_sea,rho_air,Cc,Cw,x_E,theta_s_S,theta_ic_S,...
    theta_iw_S,tau_wave_surge, tau_wave_sway)
%%
global Vc
global Vw
global Hs

%% Environmetal Load�� Relative Velocity�� ���� �߻��ϴ� ����

            % Relative Current Velocity�� ���� �߻��ϴ� ���� ����
                U_rc=Tu./m./2.*rho_sea.*Ac.*Cc.*Vrc.^2;     
                                                                                  
            % Relative Wind Velocity�� ���� �߻��ϴ� ���� ����
                U_rw=Tu./m./2.*rho_air.*Aw.*Cw.*Vrw.^2;         

        %% Wave Force
                
            U_iwave_surge=tau_wave_surge/m*Tu;                  % Surge ���� ����
            U_iwave_sway=tau_wave_sway/m*Tu;                    % Sway ���� ����
            U_iwave=sqrt(U_iwave_sway.^2+U_iwave_surge.^2);     % Wave�� ���� �߻��ϴ� ����
%             U_iwave=0;
            theta_iwave_S=atan2(U_iwave_surge, U_iwave_sway);   % Wave�� ���� �߻��ϴ� ���� ���� (��ü ����)
            
        
                

        %% ������ ȯ���������� ���� �߻��� �ӵ��� �غ����� ���ϴ� ��ü ����

                VsLackPop=zeros(1,popsize);
                for i=1:popsize

                        for j=1:npara

                            if imag(theta_s_S(i,j))>0
                               VsLackPop(i)=1;     % �ش� pop(i��) 1
                                break;
                            end
                        break;
                        end

                end
        
   

        %% ship velosity induced by thrust and environmental load
            % no environmental load
                if Vc == 0 && Vw == 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S);
                end
            % current, wind, wave
                if Vc ~= 0 && Vw ~= 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_rw.*cos(theta_iw_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % wind, wave
                if Vc == 0 && Vw ~= 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rw.*cos(theta_iw_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % current, wave
                if Vc ~= 0 && Vw == 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % current, wind
                if Vc ~= 0 && Vw ~= 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_rw.*cos(theta_iw_S); 
                end
            % current
                if Vc ~= 0 && Vw == 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S); 
                end
            % wind
                if Vc == 0 && Vw ~= 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rw.*cos(theta_iw_S); 
                end
            % wave
                if Vc == 0 && Vw == 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_iwave.*cos(theta_iwave_S); 
                end
                
                %%
                Sp=Vp.*Tu;                                   % ���� ��������� �̵��Ÿ� ���
                Sp_Hor=Sp.*sin(x_E);                           % ������ ���ι��� �̵��Ÿ� ���
                Sp_Ver=Sp.*cos(x_E);                           % ������ ���ι��� �̵��Ÿ� ���
                P_Hor=cumsum(Sp_Hor,2);                     % ������ ���ι��� ��ǥ ���
                P_Ver=cumsum(Sp_Ver,2);                     % ������ ���ι��� ��ǥ ���

        %% ������ ȯ���������� ���� �߻��� �ӵ��� �غ����� ���� ��� ��λ��� ����(�������·� ����)
                for i=1:popsize
                    if VsLackPop(i)==1
                       P_Hor(i,:)=zeros;
                       P_Ver(i,:)=zeros;
                    end
                end
    end



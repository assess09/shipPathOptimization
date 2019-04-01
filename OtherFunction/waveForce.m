%% Wave �� ���� Force ���



function [tau_wave_surge,tau_wave_sway]=...
    waveForce(m,w,spectrum,rho_sea,Tu,T0,Vs,g,...
    WaveAngle,x_E,vessel,rseed,popsize,breadth,draft)

    %% From FPSO to ���μ���. ����� ���
    % (������ ���� ����. Open�� �ڷᰡ ��� RAO�� �ٻ��ϱ� ���� ���ϴ� ����)
        % �����Ǵ� FPSO�� ���� ȣ��
            m_FPSO=vessel.main.m;
        % ��� ��� ���
            % �������� mapping ���
%                 ArtMapCoeff=0.002;
            ArtMapCoeff=1;
            mMapCoeff=m/m_FPSO*ArtMapCoeff;

    %% FPSO�� Wave1 RAO ���ġ ���
        % MSS Toolbox ���� FPSO�� Surge ���� Wave1 RAO ȣ��
            surgeRAO1_FPSO=vessel.forceRAO.amp{1};   
        % Surge RAO �� ���
            surgeRAO1_FPSO=mean(surgeRAO1_FPSO,2);
%--------------------------------------------------------------------------
        % MSS Toolbox ���� FPSO�� Sway ���� Wave1 RAO ȣ��
            swayRAO1_FPSO=vessel.forceRAO.amp{2};   
        % Sway RAO �� ���
            swayRAO1_FPSO=mean(swayRAO1_FPSO,2);

    %% FPSO�� Wave2 RAO ���ġ ���
        % MSS Toolbox ���� FPSO�� Surge ���� Wave2 RAO ȣ��
            surgeRAO2_FPSO=vessel.driftfrc.amp{1};   
        % Surge RAO �� ���
            surgeRAO2_FPSO=mean(surgeRAO2_FPSO,2);
%--------------------------------------------------------------------------
        % MSS Toolbox ���� FPSO�� Sway ���� Wave2 RAO ȣ��
            swayRAO2_FPSO=vessel.driftfrc.amp{2};   
        % Sway RAO �� ���
            swayRAO2_FPSO=mean(swayRAO2_FPSO,2);
    
    %% ���μ����� RAO �ٻ� ���
            surgeRAO1=surgeRAO1_FPSO*mMapCoeff;
            surgeRAO1=surgeRAO1(:,:,1);
            swayRAO1=swayRAO1_FPSO*mMapCoeff;
            swayRAO1=swayRAO1(:,:,1);
            surgeRAO2=surgeRAO2_FPSO*mMapCoeff;
            surgeRAO2=surgeRAO2(:,:,1);
            swayRAO2=swayRAO2_FPSO*mMapCoeff;
            swayRAO2= swayRAO2(:,:,1);
            
%             surgeRAO1=10*surgeRAO1_FPSO*mMapCoeff;
%             surgeRAO1=10*surgeRAO1(:,:,1);
%             swayRAO1=10*swayRAO1_FPSO*mMapCoeff;
%             swayRAO1=10*swayRAO1(:,:,1);
%             surgeRAO2=10*surgeRAO2_FPSO*mMapCoeff;
%             surgeRAO2=10*surgeRAO2(:,:,1);
%             swayRAO2=10*swayRAO2_FPSO*mMapCoeff;
%             swayRAO2= 10*swayRAO2(:,:,1);
    %% ���μ����� RAO Phase �ٻ簪 ����
            phaseRAO=vessel.forceRAO.phase{1};
            phaseRAO=phaseRAO(:,4);
    
    %% Wave Amplitude ���
        dw(1)=w(2)-w(1);
        dw(length(w))=w(length(w))-w(length(w)-1);
        for i=2:length(w)-1
            dw(i)=(w(i+1)-w(i))/2+(w(i)-w(i-1))/2;
            A(i,:)=sqrt(2.*spectrum(i).*dw(i));
        end
        A(length(w))=sqrt(2.*spectrum(length(w)).*dw(length(w)));
    
    %% Time Domain ����
        t=1:Tu:T0;
        
    %% Wave Force ���
        for i=1:length(w)
            w_e{i,1}=(w(i)-w(i)^2/g*Vs*cos(WaveAngle-x_E));      % Encounter Frequency ���
        end
        rand('seed',rseed);
        epsilon=max(w)*T0*rand(length(dw),1);       % ���ļ��� ��������
        
        % ���ļ� �� �����ð����� �޴� Wave Force
            for i=1:length(w)
                for  j=1:popsize
%                     tau_wave1_surge{i,1}(j,:)=rho_sea*g*surgeRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
%                     tau_wave2_surge{i,1}(j,:)=rho_sea*g*surgeRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
%                     tau_wave1_sway{i,1}(j,:)=rho_sea*g*swayRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
%                     tau_wave2_sway{i,1}(j,:)=rho_sea*g*swayRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                    tau_wave1_surge{i,1}(j,:)=surgeRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
                    tau_wave2_surge{i,1}(j,:)=surgeRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                    tau_wave1_sway{i,1}(j,:)=swayRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
                    tau_wave2_sway{i,1}(j,:)=swayRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                end
            end
        
        % ��� ���ļ��� ���� sum
            tau_temp_wave1_surge=0;
            tau_temp_wave2_surge=0;
            tau_temp_wave1_sway=0;
            tau_temp_wave2_sway=0;
            for i=1:length(w)
                tau_temp_wave1_surge=tau_temp_wave1_surge+tau_wave1_surge{i};
                tau_temp_wave2_surge=tau_temp_wave2_surge+tau_wave2_surge{i};
                tau_temp_wave1_sway=tau_temp_wave1_sway+tau_wave1_sway{i};
                tau_temp_wave2_sway=tau_temp_wave2_sway+tau_wave2_sway{i};
            end
        
        
        % 1�� �Ķ�������, 2�� �Ķ������� sum
            tau_wave_surge=tau_temp_wave1_surge+tau_temp_wave2_surge;
            tau_wave_sway=tau_temp_wave1_sway+tau_temp_wave2_sway;
%         tau_wave_surge=0;
%         tau_wave_sway=0;
        
end
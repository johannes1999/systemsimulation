% Festlegen der Parameter
%---------------------------------
Jm=1.069e-6;
i=198;
on_time = 3e-3;         %Einschaltdauer der PWM in [s]
amplitude = 8;          %Ampltide der Motorspannung/PWM in [V]
duty_cycle = 80;        %Duty cycle der PWM in [%]
pwm_periode = 16e-6;    %Periodendauer der PWM in [s]
resolution = 16;        %Auflösung der PWM [Zählerendwert]

%---------------------------------


%sim('Motor_new',[0400e-3],simset(simget('Motor_new'),'Solver','ode45','MinStep', 0.000001,'MaxStep',0.000001)); %0.00001 = 10us 0.000001 = 1us
sim('Motor_new',[0 30e-3],simset(simget('Motor_new'),'Solver','ode5','FixedStep', 1e-6)); %0.00001 = 10us 0.000001 = 1us

close all

figure(1);

subplot(2,2,1);
plot(t_out.signals.values,w_out.signals.values, t_out.signals.values, (30*w_out.signals.values/pi));
xlabel('time [s]');
ylabel('w [1/s] || n [min^-1]');
title('w');
grid on;
hold;

subplot(2,2,2);
plot(t_out.signals.values,uind_out.signals.values,t_out.signals.values,ua_out.signals.values);%t_out.signals.values,hall_impuls_out.signals.values);
xlabel('time [s]');
ylabel('uind [V]');
title('uind');
grid on;
hold;

subplot(2,2,3);
plot(t_out.signals.values,i_out.signals.values);
xlabel('time [s]');
ylabel('i [A]');
title('i');
grid on;
hold;

subplot(2,2,4);
plot(t_out.signals.values,(umdrehung_rad_out.signals.values*180/pi),t_out.signals.values,umdrehung_grad_out.signals.values);
xlabel('time [s]');
ylabel('Umdrehung [°]');
title('Motor Umdrehung');
grid on;
figure(2)
plot((umdrehung_rad_out.signals.values*180/pi),i_out.signals.values)
grid





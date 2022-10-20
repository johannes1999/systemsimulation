on_time = 3e-3;     %[s]
amplitude = 8;      %[V]
duty_cycle = 50;    %[%]
pwm_periode = 16e-6; %[s]
resolution = 16;     %

sim('pwm',[0 5e-3],simset(simget('pwm'),'Solver','ode5','FixedStep', 1e-6)); %0.00001 = 10us 0.000001 = 1us
plot(time.signals.values,pwm.signals.values)
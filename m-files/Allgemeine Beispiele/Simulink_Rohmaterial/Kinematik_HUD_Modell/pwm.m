plot(time.signals.values,pwm.signals.values)

%sim('pwm/PWM',[0 400e-3],simset(simget('pwm/PWM'),'Solver','ode5','FixedStep',1e-6)); %0.00001 = 10us 0.000001 = 1us

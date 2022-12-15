% Main Parachute Shear Pin calcs revised using Jim Jarvis's advice
% Main change: no longer using thrust
% Nancy Lindsey, 7 Dec. 2022

% Mlower is the variable that should be edited, and sometimes ashock

disp("For 4-40 nylon shear pins: ")
ashock = 19304.429133858; % = 50Gs deployment acceleration (in/s^2)
Mlower = (12.5+9.05+20.6+8.01)*0.0625; % mass of everything below the pins when the drogue shock cord extends (lb)
taumax = 9703.042; % max shear stress for nylon 6,6 (psi)
safety = 2; % factor of safety
Dbolt = 0.0939; % minor diameter of #4 shear pins (in)
Fpins = ashock*Mlower/(32.2*12); % maximum possible force on the pins (lbf)
tau = taumax/safety; % max allowable shear stress (psi)
N = Fpins/(tau*((pi/4)*(Dbolt)^2)) % number of #4 shear pins needed

disp("For 6-32 nylon shear pins: ")
Dbolt = 0.1140; % minor diameter of #6 shear pins (in)
N = Fpins/(tau*((pi/4)*(Dbolt)^2)) % number of #6 shear pins needed


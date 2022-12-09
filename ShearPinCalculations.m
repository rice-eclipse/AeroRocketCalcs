function ShearPinCalculations
% Rice Eclipse, Aerodynamics, Structures
% ShearPinCalculations.m
% Description: The 3 shear pin calculations are here: the process of 
% List of input: none
% List of output: none
% Last modified: September 15, 2022
    
    equationNumber = 5; % temporary number so the while loop can be started
    while equationNumber ~= 0 % while the inputted value is not 0 continue the loop
    % the loop allows to do continuous calculations until one is done 
        equationNumber = input("Enter 1 to solve for the number of bolts equation," + ...
            "\n2 to solve for the motor thrust equation, \n3 to solve the post drogue " + ...
            "ejection equation and \n0 to exit this script: ");

        if equationNumber == 1 % gather inputs for number of bolts equation
            % maximum shear stress is a value that corresponds to the
            % material of the shear pin and is in PSI
            t_max = input("Please enter the max shear stress value in PSI: ");

            % max force on the bolts
            F_max = input("Please enter max force on pins in lbf: ");

            % please enter diameter of bolt (for #6, #8, etc.)
            boltDiameter = input("Please enter diameter of bolt: ");

            % calls function which has equation for number of bolts and
            % outputs number of bolts
            [N] = NumberOfBolts(t_max, F_max, boltDiameter); 

            % outputs bolt diameter with units
            disp("# of bolts is this number: " + N + " rounded up") 

        elseif equationNumber == 2 % gather inputs for motor thrust equation

            % max thrust of the motor in N
            T_Max = input("Please enter the max motor thrust in N: ");

            % total rocket mass after burnout in kg
            rocketMass = input("Please enter the mass of the \nrocket (after burnout) in kg: ");

            % mass of the rocket above the ring of shear pins (kg)
            massUpper = input("Please enter the mass of the rocket \nabove the shear pins in kg: ");

            % calls function which has equation for the force on pins when
            % the rocket motor ignites and gets to its max thrust and
            % outputs the total force that all the pins will have to
            % experience
            [F_Pins] = MotorThrustEquation(T_Max, rocketMass, massUpper);

            % outputs the total force on bared by all the pins
            disp("Total force on the pins: " + F_Pins + " N") 

            % aks for number of pins
            pinNumber = input("Enter how many pins are planned to be used: ");

            % Force distributed across pins (max load that 1 pin will have
            % to withstand
            % This can be compared to the max load a pin can withstand
            % after doing a material test on material of the pin based 
            % on the expected length and diameter of the pin
            F_Pins = F_Pins/pinNumber; 

            % outputs the max load that 1 pin will have to withstand
            disp("Max load on 1 Pin: " + F_Pins + " N") 

        elseif equationNumber == 3 % gather inputs for post drogue ejection equation
            % mass below the ring of shear pins (kg) - rocket is upside
            % down 
            massLower = input("Please enter the mass of the rocket \nbelow the shear pins in kg: ");

            % calls function which has equation for the force on pins when
            % the drogue ejects and outputs the total force that all the
            % pins will have to experience
            F_Pins = PostDrogueEquation(massLower);

            % outputs the total force on bared by all the pins
            disp("Total force on the pins: " + F_Pins + " N") 

            % aks for number of pins
            pinNumber = input("Enter how many pins are planned to be used: ");

            % Force distributed across pins (max load that 1 pin will have
            % to withstand
            % This can be compared to the max load a pin can withstand
            % after doing a material test on material of the pin based 
            % on the expected length and diameter of the pin
            F_Pins = F_Pins/pinNumber; 

            % outputs the max load that 1 pin will have to withstand
            disp("Max load on 1 Pin: " + F_Pins + " N") 

        elseif equationNumber == 0 % checks if input is 0
            % leave blank

        else % if there is incorrect input ask for input again
            equationNumber = input("You did not enter a # between 0-3." + ...
            "\n2Please input again: ");
        end
    end

end

% this equation helps estimate the diameter of the bolts used as shear pins
% by using the maximum shear stress and the thrust of the engine
function [N] = NumberOfBolts(t_max, F_max, boltDiameter)
    FS = 2.0; % factor of safety - best to keep at ~2

    t_all = t_max / FS; % reducing the maximum shear stress by the factor of safety

    N = (F_max/t_all)/((pi/4)*(boltDiameter^2)); % equation for the number of bolts 
    % number - the outputted number will be rounded up to give the
    % appropriate number of bolts
end

% This equation is for the set of pins that break for the deployment
% of the drogue in the sustainer or the deployment of the main in the booster​
function [F_Pins] = MotorThrustEquation(T_Max, rocketMass, massUpper)
   a_max = T_Max/rocketMass; % max acceleration due to rocket mass and max thrust
   F_Pins = massUpper*a_max; % total force on all the pins 
end

% This equation is for the set of pins that break for the deployment
% of the main in the sustainer after the drogue has been deployed​
function [F_Pins] = PostDrogueEquation(massLower)
    % acceleration at deployment of drogue - assumed to be 50G as a safe overestimate 
    a_deploy = 490.3325; % m/s^2

    F_Pins = a_deploy*massLower; % total force on all the pins 
end
% Declare symbolic variables
syms sigma0 E E0 Ee mu
t = linspace(0, 10, 500);   % time from 0 to 10 seconds
% Maxwell----------------------------------------------------
% stress relaxation
sigma_Maxwell = sigma0 * exp(-t/mu);
% Creep
epsilon_Maxwell = sigma0*t/mu + sigma0/E;
%-----------------------------------------------------
% Voigt-------------------------------------------
% stress relaxation
sigma_voigt = sigma0;
% Creep
epsilon_voigt = sigma0./E .* (1 - exp(-E.*t./mu));
% Standard---------------------------------------------------
sigma_standard = sigma0./E0 .* (E0 + E.*exp(E.*t./mu));
epsilon_standard = sigma0 .* (1./E0 + (1./E0 + E - 1./E0) .* exp(-E0.*E./mu .* (E + E0)));
option = input('Enter a model type: 1 for Maxwell, 2 for Voigt, or 3 for standard: ');
choice = 'Y';
while choice == 'Y' || choice == 'y'
option = input('Enter a model type: 1 for Maxwell, 2 for Voigt, or 3 for standard: ');
if option ~= 1 && option ~= 2 && option ~= 3
   option = input('Enter a model type: 1 for Maxwell, 2 for Voigt, or 3 for standard: ');
elseif isempty(option)
   option = input('Enter a model type: 1 for Maxwell, 2 for Voigt, or 3 for standard: ');
end
% Option1------------------------------------------------------------------------------------
if option == 1
   sigma0 = input('Enter initial stress: ');
   E      = input('Enter stiffness: ');
   mu     = input('Enter viscosity: ');
   if isempty(E) || isempty(mu) || isempty(sigma0)
       sigma0 = input('Enter initial stress: ');
       E      = input('Enter stiffness: ');
       mu     = input('Enter viscosity: ');
   end
   sigma_Maxwell   = sigma0 * exp(-t/mu);
   epsilon_Maxwell = sigma0*t/mu + sigma0/E;
   figure;
   subplot(2,1,1);
   plot(t, sigma_Maxwell);
   xlabel('t (s)'); ylabel('\sigma(t)');
   title('Maxwell Model - Stress Relaxation');
  
   subplot(2,1,2);
   plot(t, epsilon_Maxwell);
   xlabel('t (s)'); ylabel('\epsilon(t)');
   title('Maxwell Model - Creep');
end
% Option 2-----------------------------------------------------------------
if option == 2
   sigma0 = input('Enter initial stress: ');
   E      = input('Enter stiffness: ');
   mu     = input('Enter viscosity: ');
   if isempty(E) || isempty(mu) || isempty(sigma0)
       sigma0 = input('Enter initial stress: ');
       E      = input('Enter stiffness: ');
       mu     = input('Enter viscosity:');
   end
   % stress relaxation
   sigma_voigt = sigma0;
   % Creep
   epsilon_voigt = sigma0./E .* (1 - exp(-E.*t./mu));
   figure;
   subplot(2,1,1);
   plot(t, sigma_voigt);
   xlabel('t (s)');
   ylabel('\sigma(t)');
   title('Voigt Model - Stress Relaxation');
  
   subplot(2,1,2);
   plot(t, epsilon_voigt);
   xlabel('t (s)'); ylabel('\epsilon(t)');
   title('Voigt Model - Creep');
end
% Option3--------------------------------------------------------------------
if option == 3
   sigma0 = input('Enter initial stress: ');
   E0     = input('Enter E0: ');
   E      = input('Enter stiffness E: ');
   mu     = input('Enter viscosity: ');
   if isempty(E) || isempty(mu) || isempty(sigma0) || isempty(E0)
       sigma0 = input('Enter inital stress: ');
       E0     = input('Enter E0: ');
       E      = input('Enter stiffness E: ');
       mu     = input('Enter viscosity: ');
   end
  
   sigma_standard  = sigma0./E0 .* (E0 + E.*exp(E.*t./mu));
   epsilon_standard = sigma0 .* (1./E0 + (1./E0 + E - 1./E0) .* exp(-E0.*E./mu .* (E + E0)));
   figure;
   subplot(2,1,1);
   plot(t, sigma_standard);
   xlabel('t (s)'); ylabel('\sigma(t)');
   title('Standard Linear Solid - Constant Stress');
  
   subplot(2,1,2);
   plot(t, epsilon_standard);
   xlabel('t (s)'); ylabel('\epsilon(t)');
   title('Standard Linear Solid - Creep');
end 
choice = input('Do you want to continue Y or N: ','s');
end

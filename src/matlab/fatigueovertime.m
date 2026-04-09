% --- Parameters ---
a = 0.163;   % effect of study load
b = 0.137;   % effect of academic stress
c = 0.145;   % effect of rest
d = 0.3;     % natural fatigue decay rate

% --- Survey averages ---
S_avg = 3.887;  % sl_average mean
AS_avg = 4.358; % as_average mean
R_avg = 2.431;  % sq_average mean

% --- Compute initial fatigue (F0) from survey averages ---
F0 = a*S_avg + b*AS_avg - c*R_avg;

% --- Simulation setup ---
dt = 0.1;          
T = 240;           
time = (0:T-1)*dt; 
F = zeros(1,T);    
F(1) = F0;         

% --- Study schedule (S(t)) ---
S = zeros(1,T);
for i = 1:T
   t = time(i);
   if (t >= 8 && t <= 12) || (t >= 13 && t <= 17)
       S(i) = S_avg / 5;  % normalize to 0-1
   else
       S(i) = 0;
   end
end

% --- Academic stress schedule (AS(t)) ---
AS = zeros(1,T);  % pre-allocate
for i = 1:T
   t = time(i);
   if t < 8
       AS(i) = AS_avg * 0.5;                        % low stress before study
   elseif t >= 8 && t <= 12
       AS(i) = AS_avg * (0.5 + 0.5*(t-8)/4);        % gradually rise to AS_avg in morning
   elseif t > 12 && t < 13
       AS(i) = AS_avg * 0.75;                       % moderate stress during lunch break
   elseif t >= 13 && t <= 17
       AS(i) = AS_avg * (0.75 + 0.25*(t-13)/4);     % slight rise during afternoon study
   else
       AS(i) = AS_avg * 0.5;                        % low stress during evening/night
   end
end

% --- Rest schedule (R(t)) ---
R = zeros(1,T);
for i = 1:T
   t = time(i);
   if (t > 12 && t < 13)       % lunch break
       R(i) = R_avg / 5 * 0.5; % moderate intensity
   elseif (t >= 22 || t <= 6)  % night sleep
       R(i) = R_avg / 5 * 1;   % full intensity
   else
       R(i) = 0;               % no rest other times
   end
end

% --- Euler simulation ---
for i = 1:T-1
   dFdt = a*S(i) + b*AS(i) - c*R(i) - d*F(i);
   F(i+1) = F(i) + dt*dFdt;
end

% --- Compute steady-state fatigue ---
F_ss = (a*mean(S) + b*mean(AS) - c*mean(R)) / d;

% --- Plot ---
figure;
plot(time, F, 'r-', 'LineWidth', 2);
hold on;

% Steady-state line 
yline(F_ss, 'k--', 'LineWidth', 2);
xlabel('Time (hours)');
ylabel('Fatigue Level F(t)');
title('Fatigue Over Time');
grid on;

% Highlight study hours
ymax = max(F)*1.1;
fill([8 12 12 8], [0 0 ymax ymax], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
fill([13 17 17 13], [0 0 ymax ymax], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Legend
legend('Fatigue Level', 'Steady-State Fatigue', 'Study Hours');
hold off;

% Parameters
lambda = 0; % Mean of the Poisson distribution
num_samples = 50; % Number of samples for the x-axis

% Generate Poisson distribution
x = 0:num_samples;
y = poisspdf(x, lambda);
z = fliplr(y);
poiss = [z y];
t = -length(poiss/2):2 : length(poiss/2)-1
% Plot the distribution
figure;
plot(t,poiss);
xlabel('x');
ylabel('Probability');
title('Poisson Distribution');
grid on;
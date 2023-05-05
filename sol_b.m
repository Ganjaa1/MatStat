close all; clearvars; clc;

%Simulation disk dimensions
xx0=0; yy0=0; %center of disk
r=1; %disk radius
numbLines=300;%number of lines

%Solution B
thetaB=2*pi*rand(numbLines,1); %choose angular component uniformly
pB=r*rand(numbLines,1); %choose radial component uniformly
qB=sqrt(r.^2-pB.^2); %distance to circle edge (along line)

%calculate trig values
sin_thetaB=sin(thetaB);
cos_thetaB=cos(thetaB);

%calculate chord endpoints
xxB1=xx0+pB.*cos_thetaB+qB.*sin_thetaB;
yyB1=yy0+pB.*sin_thetaB-qB.*cos_thetaB;
xxB2=xx0+pB.*cos_thetaB-qB.*sin_thetaB;
yyB2=yy0+pB.*sin_thetaB+qB.*cos_thetaB;
%calculate midpoints of chords
xxB0=(xxB1+xxB2)/2; yyB0=(yyB1+yyB2)/2;

lengthSide=r*sqrt(3); %length of triangle side
lengthB=hypot(xxB1-xxB2,yyB1-yyB2); %Method B
probEstB=mean(lengthB>lengthSide) %Method B

    %%% START Plotting START %%%
    %Solution B
    t=linspace(0,2*pi,200);
    xp=r*cos(t); yp=r*sin(t);
    
    figure;
subplot(2,2,1);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Chords of Solution B');

% iterate through each chord of Solution B
for i = 1:size(xxB1,1)
    % plot the current chord
    plot([xxB1(i);xxB2(i)],[yyB1(i);yyB2(i)],'r');
    % add a pause to create animation effect
    pause(0.01);
end



subplot(2,2,2);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Midpoints of Solution B');

% iterate through each midpoint of Solution B
for i = 1:length(xxB0)
    % plot the current midpoint
    plot(xxB0(i),yyB0(i),'r.','MarkerSize',10);
    % add a pause to create animation effect
    pause(0.01);
end

% Lengths plot
subplot(2,2,3);


% create histogram with 50 bins
histogram(lengthB, 50);
xlabel('Chord length'); ylabel('Number of chords');
title('Lengths of chords of Solution B');

% Probability density plot
subplot(2,2,4);


% calculate the probability density of a chord being shorter than a value between 0 and 2
p_shorter_than_linspace = zeros(1, 50);
space = linspace(0, 2, 50);
for i = 1:50
p_shorter_than_linspace(i) = sum(lengthB < space(i)) / length(lengthB);
end

% plot the probability density
bar(linspace(0, 2, 50), p_shorter_than_linspace);
xlabel('Chord length'); ylabel('Probability density');
title('Probability density of a chord being shorter than a value between 0 and 2');

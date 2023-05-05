close all; clearvars; clc;

%Simulation disk dimensions
xx0=0; yy0=0; %center of disk
r=1; %disk radius
numbLines=300;%number of lines

%Solution C
%choose a point uniformly in the disk
thetaC=2*pi*rand(numbLines,1); %choose angular component uniformly
pC=r*sqrt(rand(numbLines,1)); %choose radial component
qC=sqrt(r.^2-pC.^2); %distance to circle edge (alonge line)

%calculate trig values
sin_thetaC=sin(thetaC);
cos_thetaC=cos(thetaC);

%calculate chord endpoints
xxC1=xx0+pC.*cos_thetaC+qC.*sin_thetaC;
yyC1=yy0+pC.*sin_thetaC-qC.*cos_thetaC;
xxC2=xx0+pC.*cos_thetaC-qC.*sin_thetaC;
yyC2=yy0+pC.*sin_thetaC+qC.*cos_thetaC;
%calculate midpoints of chords
xxC0=(xxC1+xxC2)/2; yyC0=(yyC1+yyC2)/2;

lengthSide=r*sqrt(3); %length of triangle side
lengthC=hypot(xxC1-xxC2,yyC1-yyC2); %Method C
probEstC=mean(lengthC>lengthSide) %Method C

%create points for circle
    t=linspace(0,2*pi,200);
    xp=r*cos(t); yp=r*sin(t);
    
    %%% START Plotting START %%%
    %Solution C
    figure;
subplot(2,2,1);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Chords of Solution C');

% iterate through each chord of Solution C
for i = 1:size(xxC1,1)
    % plot the current chord
    plot([xxC1(i);xxC2(i)],[yyC1(i);yyC2(i)],'r');
    % add a pause to create animation effect
    pause(0.01);
end



subplot(2,2,2);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Midpoints of Solution C');

% iterate through each midpoint of Solution C
for i = 1:length(xxC0)
    % plot the current midpoint
    plot(xxC0(i),yyC0(i),'r.','MarkerSize',10);
    % add a pause to create animation effect
    pause(0.01);
end

% Lengths plot
subplot(2,2,3);


% create histogram with 50 bins
histogram(lengthC, 50);
xlabel('Chord length'); ylabel('Number of chords');
title('Lengths of chords of Solution C');

% Probability density plot
subplot(2,2,4);


% calculate the probability density of a chord being shorter than a value between 0 and 2
p_shorter_than_linspace = zeros(1, 50);
space = linspace(0, 2, 50);
for i = 1:50
p_shorter_than_linspace(i) = sum(lengthC < space(i)) / length(lengthC);
end

% plot the probability density
bar(linspace(0, 2, 50), p_shorter_than_linspace);
xlabel('Chord length'); ylabel('Probability density');
title('Probability density of a chord being shorter than a value between 0 and 2');

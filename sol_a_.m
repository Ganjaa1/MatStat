close all; clearvars; clc;

%Simulation disk dimensions
xx0=0; yy0=0; %center of disk
r=1; %disk radius
numbLines=300;%number of lines

thetaA1=2*pi*rand(numbLines,1); %choose angular component uniformly
thetaA2=2*pi*rand(numbLines,1); %choose angular component uniformly

%calculate chord endpoints
xxA1=xx0+r*cos(thetaA1);
yyA1=yy0+r*sin(thetaA1);
xxA2=xx0+r*cos(thetaA2);
yyA2=yy0+r*sin(thetaA2);
%calculate midpoints of chords
xxA0=(xxA1+xxA2)/2; yyA0=(yyA1+yyA2)/2;

%%%START Do some statistics on chord lengths START%%%
lengthSide=r*sqrt(3); %length of triangle side
%chord lengths
lengthA=hypot(xxA1-xxA2,yyA1-yyA2); %Method A
%probability we are looking for
probEstA=mean(lengthA>lengthSide) %Method A

%create points for circle
    t=linspace(0,2*pi,200);
    xp=r*cos(t); yp=r*sin(t);
    
    %%% START Plotting START %%%
    %Solution A
    figure;
subplot(2,2,1);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Chords of Solution A');

% iterate through each chord of Solution A
for i = 1:size(xxA1,1)
    % plot the current chord
    plot([xxA1(i);xxA2(i)],[yyA1(i);yyA2(i)],'r');
    % add a pause to create animation effect
    pause(0.01);
end



subplot(2,2,2);
%draw circle
plot(xx0+xp,yy0+yp,'k');
axis square; hold on;
xlabel('x'); ylabel('y');
title('Midpoints of Solution A');

% iterate through each midpoint of Solution A
for i = 1:length(xxA0)
    % plot the current midpoint
    plot(xxA0(i),yyA0(i),'r.','MarkerSize',10);
    % add a pause to create animation effect
    pause(0.01);
end

% Lengths plot
subplot(2,2,3);


% create histogram with 50 bins
histogram(lengthA, 50);
xlabel('Chord length'); ylabel('Number of chords');
title('Lengths of chords of Solution A');

% Probability density plot
subplot(2,2,4);


% calculate the probability density of a chord being shorter than a value between 0 and 2
p_shorter_than_linspace = zeros(1, 50);
space = linspace(0, 2, 50);
for i = 1:50
p_shorter_than_linspace(i) = sum(lengthA < space(i)) / length(lengthA);
end

% plot the probability density
bar(linspace(0, 2, 50), p_shorter_than_linspace);
xlabel('Chord length'); ylabel('Probability density');
title('Probability density of a chord being shorter than a value between 0 and 2');

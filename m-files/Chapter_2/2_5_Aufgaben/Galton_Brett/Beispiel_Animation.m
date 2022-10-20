%% Trace Marker Along Line
% This example shows how to trace a marker along a line by updating the data 
% properties of the marker. 
% 
% Plot a sine wave and a red marker at the beginning of the line. Set the 
% axis limits mode to manual to avoid recalculating the limits throughout the 
% animation loop.
clear all
close all
Fall=2;

switch Fall
    case 1

    figure
        x = linspace(0,10,1000);
        c_ball=circle(0,0, 0.5,0, 2*pi); % Nullposition der Kugel
        y = sin(x);
        plot(x,y)
        axis('equal')
        hold on
        p = plot(x(1),y(1),'o','MarkerFaceColor','red');
        hold off
        axis manual
    %% 
    % Move the marker along the line by updating the |XData| and |YData| properties 
    % in a loop. Use a <docid:matlab_ref.f56-719157 docid:matlab_ref.f56-719157> or 
    % |drawnow limitrate| command to display the updates on the screen. |drawnow limitrate| 
    % is fastest, but it might not draw every frame on the screen. Use dot notation to set properties. 
    %%
    for k = 2:length(x)
        p.XData = x(k);
        p.YData = y(k);
        drawnow 
    end
    %% 
    % The animation shows the marker moving along the line.

    %% 
    % Copyright 2012 The MathWorks, Inc.
    %% 
  case 2   
  figure;
%     plot([-43 -43],[50 210],'k','LineWidth',3)
%     hold on;
%     plot([43 43],[50 210],'k','LineWidth',3)
%     plot([-43 43],[210 210],'k','LineWidth',3)
    axis equal;
    t=0:1;
    fanimator(@(t) plot([0 50*sin(t)],[0 50*cos(t)],'r-','LineWidth',3))
    playAnimation('FrameRate',30)
end


    
    
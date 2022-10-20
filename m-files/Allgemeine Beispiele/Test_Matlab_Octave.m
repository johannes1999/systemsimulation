% Test_Matlab_Octave
%
% m-file ruft alle m-Files und functions auf um neue Versionen von Matlab
% und Octave zu testen

% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-03-17
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clear all;  % workspace löschen. Neue matlab-Version nutzt clearvars!
Chapter=1;

if Chapter==1
    %1_2_M-files		
		ABCformula;
		ABCformula_mfile_debugging;
		debug_abc;
		%mfile_debugging1;
		%mfile_debugging2;
		%mfile_debugging3;
    %1_3_Visualisation		
	%Plot 2D	
		%AxisLinking
		AxisLinking
		
		%Double y-axis
		DoubleYAxis
		DoubleYAxisDifferentAxisStyles
		
		%Histogram
		Histogram
		
		%Line Types
		LineTypes
		LineAttributes
		LineAttributesMoreExamples
		
		%Log Plots
		LogPlots
		
		%Multiple Plots
		MultiplePlots
		
		%Other Plots
		OtherPlot
		
		%Polar Plots
		PolarPlot
		
		%Setting Axes
		SettingAxes
		SettingAxes_2
		
		
		%Simple Plot
		simple_plot1
		simple_plot2
		simple_plot3
		simple_plot4
		simple_plot5
		
		%Subplot
		Subplots
		Subplots_2
		
	%Plot 3D	
		%Contour
		Contour1
		Contour2
		
		%MeshSurface
		MeshSurface
		MeshSurface2
		MeshSurface3
		
		%Simple3DPlot
		Simple3DPlot
		Other3DPlots
		
	%Plot Exercise	
		plot_exercise
		
%1_4_Control_Structure		
	%Break	
		BreakExample
		BreakExampleNoBreak
		
	%Continue	
		ContinueExample
		ContinueExampleNoContinue
		
	%For	
		ForLoop
		NestedForLoop
		NestedWhileLoop_WithAProblem
		
	%IfThenElse	
		IfThenElseExample
		
	%Switch	
		SwitchExample1
		SwitchExample2
		
	%While	
		WhileLoop
		fractal
		
%1_5_Function		
	%Binomial	
		binomial
		
	%Binomial Recursive Factorial	
		binomial
		
	%isPrimeNumber1	
		isPrimeNumber
		isPrimeNumber_ExitReturn
		rectangle_01
		
	%Scope	
		scope
		
	%Function Handle	
		Test_fkt_handle
		%numdiff_1.m
		%sin_cardinalis.m
		
%1_6_Exercise		
		ball_main
		%ball.m
		bounce.m


elseif Chapter==2
end



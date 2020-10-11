
%import spreadsheet. add to path and open it.  

SpreadName=input("please enter the spreadsheet name without the extension   "); %enter name of file

numFilters=input("Please input the number of filters you would like to run. Each filter eliminates half of the data   \nIf unsure, go with 4 \n");

%cuts out every other point
for repeter=1:1:numFilters
    SpreadName(2:2:end,:) = []; %eliminates half of the data
end
%processing
SpreadName.rad=SpreadName{:,3}*3.14159/180; %converts degrees to radians
SpreadName.Properties.VariableNames{1} = 'z';   %renaming columns, not required for running
SpreadName.Properties.VariableNames{4} = 'd';   %renaming columns, not required for running
SpreadName.Properties.VariableNames{3} = 'deg';   %renaming columns, not required for running
SpreadName.x=SpreadName{:,4}.*cos(SpreadName{:,5}); %elementwise operation to find x coordinates
SpreadName.y=SpreadName{:,4}.*sin(SpreadName{:,5}); %elementwise operation to find y coordinates
X=SpreadName(:,6);  %reference assignments
X=table2array(X);   %converting the table to an array for proccessing
Y=SpreadName(:,7);
Y=table2array(Y);
Z=SpreadName(:,1);
Z=table2array(Z);


q=[X,Y,Z];
writematrix(q,'XYZ1.txt');
type 'XYZ1.txt';
figure(1);
scatter3(X,Y,Z)



disp("done");
%gridding
ti=-1524:1:1524;                %sets disance for grid to be mapped on
[XI,YI] = meshgrid(ti,ti);      %creates the grid which allows for a mesh to be made. 
ZI = griddata(X,Y,Z,XI,YI);     %neccessary to create a 3D mesh in matlab
figure(2);
surf(XI,YI,ZI);
figure(3);
%contour3(X,Y,Z)
contour3(XI,YI,ZI)
figure(4);
mesh(XI,YI,ZI)
%surf2stl('testSTL2.stl', XI,YI,ZI);
%labels
xlabel('Position along X grid, parallel to rock face (mm)')
ylabel('Position along Y grid, parallel to rock face (mm)')
zlabel('Position along z axis, depth into bore, 0 is the deepest point (mm)')

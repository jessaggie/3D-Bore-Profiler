%this program takes in the csv data from a 3D bore profiling run and
%reorganizes the data by angle and standoff. 

%you need to pass in the name of the file you want to read and the name of
%the file to be created. 

SpreadName=input("please enter the spreadsheet name without the extension   "); %enter name of file
outputName=input("please enter the file name for export with the .csv extension with single quotes   "); %enter name of file

SpreadName.Properties.VariableNames{1} = 'Standoff';   %renaming columns, not required for running
SpreadName.Properties.VariableNames{2} = 'Quality';
SpreadName.Properties.VariableNames{3} = 'Angle';
SpreadName.Properties.VariableNames{4} = 'Distance';
SpreadName(:,2) = [];                                   %drops column
SpreadName.Angle=round(SpreadName.Angle);               %rounds values so we have whole number angles
SpreadName=rmoutliers(SpreadName, 'quartiles');
unstacked=unstack(SpreadName, 'Distance', 'Angle');     %reorganizes data so the angles are the variables instead
sorted=sortrows(unstacked);                             %sorts rows 
%sorted = fillmissing(sorted,'next');                    %fills in missing values by grabbing next value
%sorted = fillmissing(sorted,'previous');                %fills in missing values by grabbing previous value
Angle_Grouping=[];                                             %initialzing array
sortedArray=table2array(sorted(:,2:end));               %makes a new array from sorted out of the angle columns and stores it as an array
[h,w]=size(sortedArray);                                 %gets size of sorted array to set the number of times to iterate
for i=1:h
    for j=1:120
        Angle_Grouping(i,j)=mean(sortedArray(i, 3*j-2:3*j));   %iterates through sorted array and puts average values in a new column in the output array
    end
end
Angle_Grouping=array2table(Angle_Grouping);                           %converts the array back to a table
exprt=[sorted(:,1), Angle_Grouping(:,:)];                      %Makes a new table and combines the standoff with the angle data
exprt= fillmissing(exprt,'previous');
exprt = fillmissing(exprt,'next');                    %fills in missing values by grabbing next value
writetable(exprt, outputName);               %writes out data to a csv file
%% read ITK 3D affine transformation
% Yang Yu, 09/22/2015
%
function [Rotation,Translation,Center] = readAffine(filename)

fileID = fopen(filename);
text = textscan(fileID,'%s','delimiter','\n');

Rotation = eye(3,3);

Translation = zeros(3,0);
Center = zeros(3,0);

[n, m]= size(text{1,1});

for j=1:n
  
    str = text{1,1}{j,1};
    
    if (strncmpi(str,'Parameters:',1) == true)
        
        line = textscan(str,'%s%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',' ');
   
        Rotation(1,1) = line{1,2};
        Rotation(1,2) = line{1,3};
        Rotation(1,3) = line{1,4};
        
        Rotation(2,1) = line{1,5};
        Rotation(2,2) = line{1,6};
        Rotation(2,3) = line{1,7};
        
        Rotation(3,1) = line{1,8};
        Rotation(3,2) = line{1,9};
        Rotation(3,3) = line{1,10};
        
        Translation(1) = line{1,11};
        Translation(2) = line{1,12};
        Translation(3) = line{1,13};
    
    elseif (strncmpi(str,'FixedParameters:',1) == true)
            
        line = textscan(str,'%s%f%f%f','delimiter',' ');
        
        Center(1) = line{1,2};
        Center(2) = line{1,3};
        Center(3) = line{1,4};
        
    end
    
    
end

fclose(fileID);
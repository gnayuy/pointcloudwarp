%% read swc
% Yang Yu, 09/22/2015

function swc = readswc(filename)

% n, m, x, y, z, radius, parent

fileID = fopen(filename);
text = textscan(fileID,'%s','delimiter','\n');

i=1;

[n, m]= size(text{1,1});

for j=1:n
  
    str = text{1,1}{j,1};
    
    if(strncmpi(str,'#',1) ~= true)
        
        line = textscan(str,'%d%d%f%f%f%f%d','delimiter',' ');
        
        swc(i,1) = single(line{1,1});
        swc(i,2) = single(line{1,2});
        
        swc(i,3) = single(line{1,3}); % x
        swc(i,4) = single(line{1,4}); % y
        swc(i,5) = single(line{1,5}); % z
        
        swc(i,6) = single(line{1,6});
        swc(i,7) = single(line{1,7});
        
        i=i+1;
    end
    
end

fclose(fileID);
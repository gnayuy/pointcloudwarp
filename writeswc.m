%% write swc
% Yang Yu, 09/22/2015

function writeswc(filename, swc)

fid = fopen(filename, 'w');

fprintf(fid, '#comment \n');

[n,m] = size(swc);

for i = 1:n
   
    fprintf(fid, '%d %d %f %f %f %f %d \n', swc(i,1), swc(i,2), swc(i,3), swc(i,4), swc(i,5), swc(i,6), swc(i,7));
    
end
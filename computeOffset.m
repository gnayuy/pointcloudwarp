%% compute offset
% Yang Yu, 09/22/2015

function offset = computeOffset(translation, center, matrix, dims)

offset = translation;

for i = 1:dims
    
    offset(i) = translation(i) + center(i);
   
    for j = 1:dims
       
        offset(i) = offset(i) - matrix(i,j)*center(j);
        
    end
    
end

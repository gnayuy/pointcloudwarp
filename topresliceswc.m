%% switch y and z
% Yang Yu, 09/22/2015

function swc = topresliceswc(inswc)

swc = inswc;

swc(:,4) = inswc(:,5);
swc(:,5) = inswc(:,4);


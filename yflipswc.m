%% yflip swc
% Yang Yu, 09/22/2015

function swc = yflipswc(inswc, dimy)

swc = inswc;
swc(:,4) = dimy - inswc(:,4);
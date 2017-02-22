%% zflip swc
% Yang Yu, 09/22/2015

function swc = zflipswc(inswc, dimz)

swc = inswc;
swc(:,5) = dimz - inswc(:,5);
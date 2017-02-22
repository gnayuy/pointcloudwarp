%% xflip swc
% Yang Yu, 09/22/2015

function swc = xflipswc(inswc, dimx)

swc = inswc;
swc(:,3) = dimx - inswc(:,3);
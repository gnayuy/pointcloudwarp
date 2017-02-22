%% scale swc
% Yang Yu, 09/22/2015

function swc = scaleswc(inswc, scalefactor)

swc = inswc;
swc(:,3) = inswc(:,3)*scalefactor;
swc(:,4) = inswc(:,4)*scalefactor;
swc(:,5) = inswc(:,5)*scalefactor;

swc(:,6) = inswc(:,6)*scalefactor;
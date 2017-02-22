%% warping swc example

% swc = warpswc('KC_abs.swc','lmccAffine.txt');
swc = warpswc('MBON-a_3.swc','lmccAffine.txt');

% writeswc('testKC.swc', swc);

swc = xflipswc(swc,198); % [198,376,273]
swc = topresliceswc(swc);

swc = scaleswc(swc,2.0);

writeswc('MBON-a_3_affreg.swc', swc);
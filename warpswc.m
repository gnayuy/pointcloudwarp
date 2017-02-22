%% script for warping swc given an affine transformation
% Yang Yu, 09/22/2015

function outswc = warpswc(inswc,affinetransform, deformation)

swc = readswc(inswc);

[R,t,c] = readAffine(affinetransform);

offset = computeOffset(t, c, R, 3);

aff = eye(4,4);

aff(1:3,1:3) = R;
aff(1:3,4) = offset;

[n,m] = size(swc);

p = ones(4,n);

p(1,:) = swc(:,3);
p(2,:) = swc(:,4);
p(3,:) = swc(:,5);

q=aff\p; % inv(aff)*p

outswc=swc;
outswc(:,3) = q(1,:);
outswc(:,4) = q(2,:);
outswc(:,5) = q(3,:);

if ~exist('deformation','var')
    
    disp('only affine transformation is applied')
    
else
    
    warp = load_nii(deformation);
    
    sx = warp.hdr.dime.dim(2);
    sy = warp.hdr.dime.dim(3);
    sz = warp.hdr.dime.dim(4);
    
    swc = outswc;
    
    for i=1:n
        
        x = swc(i,3);
        y = swc(i,4);
        z = swc(i,5);
        
        if(x>0 && x<=sx && y>0 && y<=sy && z>0 && z<=sz)
        
            x_s=floor(x);  
            y_s=floor(y);  
            z_s=floor(z);  
            
            if x_s<1
                x_s=1;
            end
            
            if y_s<1
                y_s=1
            end
            
            if z_s<1
                z_s=1
            end
            
            x_e=ceil(x);
            y_e=ceil(y);
            z_e=ceil(z);
            
            if x_e > sx
                x_e = sx
            end
            
            if y_e > sy
               y_e = sy
            end
            
            if z_e > sz
                z_e = sz
            end

            l = 1.0 - (x-single(x_s)); r = 1.0 -l;
            u = 1.0 - (y-single(y_s)); d = 1.0 -u;
            f = 1.0 - (z-single(z_s)); b = 1.0 -f;
            
            i1 = warp.img(x_s,y_s,z_s,1,1)*f + warp.img(x_s,y_s,z_e,1,1)*b;
            i2 = warp.img(x_s,y_e,z_s,1,1)*f + warp.img(x_s,y_e,z_e,1,1)*b;
            j1 = warp.img(x_e,y_s,z_s,1,1)*f + warp.img(x_e,y_s,z_e,1,1)*b;
            j2 = warp.img(x_e,y_e,z_s,1,1)*f + warp.img(x_e,y_e,z_e,1,1)*b;
            
            w1 = i1 * u + i2 * d;
            w2 = j1 * u + j2 * d;
            
            offx = w1 * l + w2 * r;
            
            i1 = warp.img(x_s,y_s,z_s,1,2)*f + warp.img(x_s,y_s,z_e,1,2)*b;
            i2 = warp.img(x_s,y_e,z_s,1,2)*f + warp.img(x_s,y_e,z_e,1,2)*b;
            j1 = warp.img(x_e,y_s,z_s,1,2)*f + warp.img(x_e,y_s,z_e,1,2)*b;
            j2 = warp.img(x_e,y_e,z_s,1,2)*f + warp.img(x_e,y_e,z_e,1,2)*b;
            
            w1 = i1 * u + i2 * d;
            w2 = j1 * u + j2 * d;
            
            offy = w1 * l + w2 * r;

            i1 = warp.img(x_s,y_s,z_s,1,3)*f + warp.img(x_s,y_s,z_e,1,3)*b;
            i2 = warp.img(x_s,y_e,z_s,1,3)*f + warp.img(x_s,y_e,z_e,1,3)*b;
            j1 = warp.img(x_e,y_s,z_s,1,3)*f + warp.img(x_e,y_s,z_e,1,3)*b;
            j2 = warp.img(x_e,y_e,z_s,1,3)*f + warp.img(x_e,y_e,z_e,1,3)*b;
            
            w1 = i1 * u + i2 * d;
            w2 = j1 * u + j2 * d;
            
            offz = w1 * l + w2 * r;

            outswc(i,3) = swc(i,3) + offx;
            outswc(i,4) = swc(i,4) + offy;
            outswc(i,5) = swc(i,5) + offz;
        
        end
        
    end
    
end


[mX,mY] = meshgrid([0:.125:9],[0:.125:3]);
mZ = peaks(mX,mY);
meshc(mX,mY,mZ);
axis equal;
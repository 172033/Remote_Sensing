% *****measured brightness temperatures************************************
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)


% High ice concentration situation (line 14 in high ice concentration data set)
% Expected value of p = [4.35 11.9486 0.13957 271.46 273.16 1 -] 
TB = [228.5 257.63 235.47 260.06 243.71 262.18 251.01 263.94 251.87 262.41]; 

[p,S] = InverseModel(TB)





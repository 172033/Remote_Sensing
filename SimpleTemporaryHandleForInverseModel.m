

% *****measured brightness temperatures************************************
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)

TB = [160 80 169 86 185 102 196 122 211 140];

p = InverseModel(TB)

% expected values for the given brightness temperature: [5.04, 3.8445, 0.00144, 278.07, 271.46, 0, 0]

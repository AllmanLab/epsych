function X = checkFixate2(currentValue, initBuffSize)

persistent P i

X = 0;

if isnan(currentValue)
    currentValue = -1*randi(100);
end

if nargin == 1
    initBuffSize = 15;
end

if isempty(P)
    P = randi(99,initBuffSize,1);
    i = 1;
end

if i > initBuffSize, i = 1; end

P(i) = currentValue;
fixedPoint = P(i);
i = i + 1;
if currentValue == 6
    X = all(P==P(1));
else
    X = 0;
end

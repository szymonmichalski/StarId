% =========================================================================
%
% CreateParabKvector.m
%
% THESIS: FAST STAR PATTERN RECOGNITION USING SPHERICAL TRIANGLES
% Craig L Cole
% 8 January 2003
%
% Creates K-Vector array based on parabola connecting first and last
% points of sorted data
%
% INPUTS:   Prop - Array of data for which K-Vector is created
%
% OUTPUT:   Kvec - structured array of K-vector
%             .Ptr - pointer array to sorted data
%             .A   - x-coefficient
%             .B   - y-intercept
%
% SUBROUTINES REQUIRED: none
%
% =========================================================================

function Kvec = CreateParabKvector( Prop )

n = size( Prop, 2 );    % Determine size of array (its 1-d)

Kvec.Ptr  = zeros( 1, n );

% Calculate parabola which passes through first and last point
% Area = a*index^2 + b

Kvec.A = ( Prop( n ) - Prop( 1 ) )/(n^2-1);
Kvec.B = Prop( 1 ) - Kvec.A*1^2;

% Plot as desired

figure(2);
i = 1:n;
y = Kvec.A * i.^2 + Kvec.B;
plot(1:n, [Prop(:)], 1:n, y(:));

% Create K-vector

j = 1;
for i = 1:n-1

    if (i/1000) == floor(i/1000)
        [i n]
    end
    
    y = Kvec.A*i^2 + Kvec.B;
    
    % Want K-Vector at i to refer to index of Area closest to but 
    % not over Area resulting from parabola equation

    while Prop(j) <= y
        j = j + 1;
        if j > n
            j = n;
            break;
        end
    end
   
    j = j - 1;      % while loop ends at one index too high
                    % comment above line to make D'Mortari K-Vector
    Kvec.Ptr(i) = j;
end

Kvec.Ptr(n) = n;      % must set Kvec(n) manually
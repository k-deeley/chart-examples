function cmap = money()
%MONEY Custom red/green colormap.

arguments ( Output )
    cmap(:, 3) double {mustBeBetween( cmap, 0, 1 )}
end % arguments ( Output )

t = linspace( 0, 1, 256 ).';
cmap = [t, flip( t ), zeros( size( t ) )];

end % money
function mustBeLegendLocation( option )
%MUSTBELEGENDLOCATION Validate that the given input string, option,
%represents a valid location for a legend object.

locationValues = set( groot(), "DefaultLegendLocation" );
mustBeMember( option, locationValues )

end % mustBeLegendLocation
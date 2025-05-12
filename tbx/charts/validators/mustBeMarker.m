function mustBeMarker( marker )
%MUSTBEMARKER Validate that the given string, marker, represents a valid
%marker value for a line or scatter object.

markerValues = set( groot(), "DefaultLineMarker" );
mustBeMember( marker, markerValues )

end % mustBeMarker
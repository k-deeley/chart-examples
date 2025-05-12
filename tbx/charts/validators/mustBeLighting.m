function mustBeLighting( option )
%MUSTBELIGHTING Validate that the given input string, option, represents a 
%valid lighting option for a surface object.

lightingValues = set( groot(), "DefaultSurfaceFaceLighting" );
mustBeMember( option, lightingValues )

end % mustBeLighting
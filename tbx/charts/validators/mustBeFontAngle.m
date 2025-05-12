function mustBeFontAngle( fontAngle )
%MUSTBEFONTANGLE Validate that the given string, fontAngle, represents a 
%valid font angle value for a text object.

fontAngleValues = set(groot(), "DefaultTextFontAngle" );
mustBeMember( fontAngle, fontAngleValues )

end % mustBeFontAngle


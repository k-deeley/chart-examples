function mustBeFontWeight( fontWeight )
%MUSTBEFONTWEIGHT Validate that the given string, fontWeight, represents a
%valid font angle weight for a text object.

fontWeightValues = set( groot(), "DefaultTextFontWeight" );
mustBeMember( fontWeight, fontWeightValues )

end % mustBeFontWeight
function mustBeLineStyle( style )
%MUSTBELINESTYLE Validate that the given string, style, represents a valid
%line style value for a line object.

lineStyleValues = set( groot(), "DefaultLineLineStyle" );
mustBeMember( style, lineStyleValues )

end % mustBeLineStyle
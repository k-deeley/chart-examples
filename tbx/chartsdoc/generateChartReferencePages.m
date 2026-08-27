function generatedFiles = generateChartReferencePages()
%GENERATECHARTREFERENCEPAGES Generate chart reference documentation.

% Copyright 2026 The MathWorks, Inc.

arguments ( Output )
    generatedFiles(:, 1) string
end % arguments ( Output )

docRoot = fileparts( mfilename( "fullpath" ) );
projectRoot = fullfile( docRoot, "..", ".." );
chartFolder = fullfile( projectRoot, "tbx", "charts", "charts" );
testFolder = fullfile( projectRoot, "tbx", "charts", "tests" );
exampleFolder = fullfile( docRoot, "examples" );
outputFolder = fullfile( docRoot, "charts" );

if ~isfolder( outputFolder )
    mkdir( outputFolder )
end % if

chartInfo = dir( fullfile( chartFolder, "*.m" ) );
chartNames = sort( erase( string( {chartInfo.name} ), ".m" ) ).';
descriptions = getChartDescriptions( docRoot );

generatedFiles = strings( 0, 1 );
generatedFiles(end + 1, 1) = writeChartIndex( ...
    outputFolder, chartNames, descriptions );
generatedFiles(end + 1, 1) = writeHelpToc( ...
    docRoot, chartNames, testFolder );

for chartIdx = 1 : numel( chartNames )
    chartName = chartNames(chartIdx);
    newFiles = writeChartPages( ...
        outputFolder, chartName, descriptions, chartFolder, ...
        exampleFolder, testFolder );
    generatedFiles = [generatedFiles; newFiles]; %#ok<AGROW>
end % for

fprintf( 1, "[+] Generated %d chart reference pages.\n", ...
    numel( generatedFiles ) )

end % generateChartReferencePages

function descriptions = getChartDescriptions( docRoot )
%GETCHARTDESCRIPTIONS Read chart descriptions from the chart index.

arguments ( Input )
    docRoot(1, 1) string
end % arguments ( Input )

arguments ( Output )
    descriptions containers.Map
end % arguments ( Output )

descriptions = containers.Map( "KeyType", "char", "ValueType", "char" );
indexFile = fullfile( docRoot, "ChartExamples.md" );
if ~isfile( indexFile )
    return
end % if

lines = readlines( indexFile );
expr = "^\* \[`(?<name>[^`]+)`\]\([^)]+\) - (?<text>.+)$";
for idx = 1 : numel( lines )
    tokens = regexp( lines(idx), expr, "names" );
    if ~isempty( tokens )
        descriptions( char( tokens.name ) ) = char( tokens.text );
    end % if
end % for

end % getChartDescriptions

function outputFile = writeChartIndex( ...
        outputFolder, chartNames, descriptions )
%WRITECHARTINDEX Write the chart reference index.

arguments ( Input )
    outputFolder(1, 1) string
    chartNames(:, 1) string
    descriptions containers.Map
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# Chart Reference"
    ""
    "Each chart reference page links to the class documentation and " + ...
    "examples, source code listing, and chart-specific test code " + ...
    "listing when a matching test exists."
    ""
    "## Section Contents"
    ""];

for chartName = chartNames.'
    description = lookupDescription( descriptions, chartName );
    lines(end + 1, 1) = "* [`" + chartName + "`](" + ...
        chartName + ".md) - " + description; %#ok<AGROW>
end % for

lines = [
    lines
    ""
    "## Shared Test Infrastructure"
    ""
    "* [`tChart`](../../charts/tests/tChart.m) - common " + ...
    "constructor and parentage tests used by chart-specific tests."
    ""];

outputFile = fullfile( outputFolder, "ChartsIndex.md" );
writeTextFile( outputFile, lines )

end % writeChartIndex

function outputFile = writeHelpToc( docRoot, chartNames, testFolder )
%WRITEHELPTOC Write the documentation table of contents.

arguments ( Input )
    docRoot(1, 1) string
    chartNames(:, 1) string
    testFolder(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# Chart Examples"
    ""
    "* [Chart Examples](index.md)"
    "  * [Getting Started](GettingStarted.md)"
    "  * [Release Notes](Changelog.md)"
    "  * [Development Notes](DevelopmentNotes.md)"
    "    * [What is a Chart?](notes/WhatIsAChart.md)"
    "    * [Chart Development Guide](notes/ChartDevelopmentGuide.md)"
    "    * [Creating Specialized Charts with MATLAB " + ...
    "Object-Oriented Programming](notes/TechnicalArticle.md)"
    "  * [Chart Reference](ChartExamples.md)"
    "    * [Chart Reference Index](charts/ChartsIndex.md)"];

for chartName = chartNames.'
    testFile = findTestFile( testFolder, chartName );
    lines(end + 1, 1) = "    * [" + chartName + "](charts/" + ...
        chartName + ".md)"; %#ok<AGROW>
    lines(end + 1, 1) = "      * [Class Documentation and " + ...
        "Examples](charts/" + chartName + ...
        "ClassReference.md)"; %#ok<AGROW>
    lines(end + 1, 1) = "      * [Source Code Listing](charts/" + ...
        chartName + "SourceCode.md)"; %#ok<AGROW>
    if strlength( testFile ) > 0
        lines(end + 1, 1) = "      * [Unit Test Listing](charts/" + ...
            chartName + "UnitTest.md)"; %#ok<AGROW>
    end % if
end % for

outputFile = fullfile( docRoot, "helptoc.md" );
writeTextFile( outputFile, lines )

end % writeHelpToc

function outputFiles = writeChartPages( outputFolder, chartName, ...
        descriptions, chartFolder, exampleFolder, testFolder )
%WRITECHARTPAGES Write chart reference pages.

arguments ( Input )
    outputFolder(1, 1) string
    chartName(1, 1) string
    descriptions containers.Map
    chartFolder(1, 1) string
    exampleFolder(1, 1) string
    testFolder(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFiles(:, 1) string
end % arguments ( Output )

description = lookupDescription( descriptions, chartName );
exampleFile = fullfile( exampleFolder, chartName + ".md" );
sourceFile = fullfile( chartFolder, chartName + ".m" );
testFile = findTestFile( testFolder, chartName );

outputFiles = strings( 3, 1 );
outputFiles(1) = writeChartPage( ...
    outputFolder, chartName, description, exampleFile, testFile );
outputFiles(2) = writeClassReferencePage( ...
    outputFolder, chartName, description, exampleFile, testFile );
outputFiles(3) = writeSourceCodePage( ...
    outputFolder, chartName, sourceFile );
if strlength( testFile ) > 0
    outputFiles(end + 1, 1) = writeUnitTestPage( ...
        outputFolder, chartName, testFile );
end % if

end % writeChartPages

function outputFile = writeChartPage( ...
        outputFolder, chartName, description, exampleFile, testFile )
%WRITECHARTPAGE Write one chart reference landing page.

arguments ( Input )
    outputFolder(1, 1) string
    chartName(1, 1) string
    description(1, 1) string
    exampleFile(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# `" + chartName + "`"
    ""
    capitalizeFirstLetter( description )
    ""];

imageLink = extractImageLink( exampleFile );
if strlength( imageLink ) > 0
    lines = [lines; imageLink; ""];
end % if

lines = [
    lines
    "* [Class Documentation and Examples](" + ...
    chartName + "ClassReference.md)"
    "* [Source Code Listing](" + chartName + "SourceCode.md)"];
if strlength( testFile ) > 0
    lines = [
        lines
        "* [Unit Test Listing](" + chartName + "UnitTest.md)"];
else
    lines = [
        lines
        "* No chart-specific test code listing exists."
        ""];
end % if

outputFile = fullfile( outputFolder, chartName + ".md" );
writeTextFile( outputFile, lines )

end % writeChartPage

function outputFile = writeClassReferencePage( outputFolder, chartName, ...
        description, exampleFile, testFile )
%WRITECLASSREFERENCEPAGE Write one chart class reference page.

arguments ( Input )
    outputFolder(1, 1) string
    chartName(1, 1) string
    description(1, 1) string
    exampleFile(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

classInfo = meta.class.fromName( chartName );
overview = extractOverviewSummary( exampleFile );
exampleLines = extractExampleSection( exampleFile );
propertyRows = publicPropertyRows( classInfo, chartName );
methodRows = publicMethodRows( classInfo, chartName );
outputName = constructorOutputName( chartName, exampleFile );

lines = [
    "# `" + chartName + "`"
    ""
    capitalizeFirstLetter( description )
    ""
    "## Description"
    ""
    overview
    ""
    "## Syntax"
    ""
    "```matlab"
    chartName + "()"
    chartName + "(name, value, ...)"
    outputName + " = " + chartName + "(name, value, ...)"
    "```"
    ""
    "## Input Arguments"
    ""
    "All `" + chartName + "` inputs are optional name-value arguments."
    ""
    "## Properties"
    ""
    "| Name | Description | Type | Default Value | Access |"
    "| --- | --- | --- | --- | --- |"
    propertyRows
    ""
    "## Methods"
    ""
    "| Name | Description |"
    "| --- | --- |"
    methodRows
    ""
    "## Examples"
    ""
    exampleLines
    ""
    "## See Also"
    ""
    "* [`" + chartName + "`](" + chartName + ".md)"
    "* [Source Code Listing](" + chartName + "SourceCode.md)"];

if strlength( testFile ) > 0
    lines = [
        lines
        "* [Unit Test Listing](" + chartName + "UnitTest.md)"];
end % if

lines = [
    lines
    "* [Chart Reference](ChartsIndex.md)"
    ""];

outputFile = fullfile( outputFolder, chartName + "ClassReference.md" );
writeTextFile( outputFile, lines )

end % writeClassReferencePage

function outputFile = writeSourceCodePage( outputFolder, chartName, ...
        sourceFile )
%WRITESOURCECODEPAGE Write one chart source code listing page.

arguments ( Input )
    outputFolder(1, 1) string
    chartName(1, 1) string
    sourceFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# `" + chartName + "` Source Code"
    ""
    "Source file: [`" + chartName + ".m`](../../charts/charts/" + ...
    chartName + ".m)."
    ""
    codeListing( sourceFile )
    ""
    "## See Also"
    ""
    "* [`" + chartName + "`](" + chartName + ".md)"
    "* [Chart Reference](ChartsIndex.md)"
    ""];

outputFile = fullfile( outputFolder, chartName + "SourceCode.md" );
writeTextFile( outputFile, lines )

end % writeSourceCodePage

function outputFile = writeUnitTestPage( ...
        outputFolder, chartName, testFile )
%WRITEUNITTESTPAGE Write one chart unit test listing page.

arguments ( Input )
    outputFolder(1, 1) string
    chartName(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

[~, testName, ext] = fileparts( testFile );
lines = [
    "# `" + chartName + "` Unit Test"
    ""
    "Test file: [`" + testName + ext + "`](../../charts/tests/" + ...
    testName + ext + ")."
    ""
    codeListing( testFile )
    ""
    "## See Also"
    ""
    "* [`" + chartName + "`](" + chartName + ".md)"
    "* [Chart Reference](ChartsIndex.md)"
    ""];

outputFile = fullfile( outputFolder, chartName + "UnitTest.md" );
writeTextFile( outputFile, lines )

end % writeUnitTestPage

function outputName = constructorOutputName( chartName, exampleFile )
%CONSTRUCTOROUTPUTNAME Return a documented constructor output name.

arguments ( Input )
    chartName(1, 1) string
    exampleFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputName(1, 1) string
end % arguments ( Output )

outputName = chartInitials( chartName );
if ~isfile( exampleFile )
    return
end % if

expr = "^([A-Z][A-Z0-9]*)\s*=\s*" + chartName + "\(";
lines = readlines( exampleFile );
for idx = 1:numel( lines )
    tokens = regexp( lines(idx), expr, "tokens", "once" );
    if ~isempty( tokens )
        outputName = string( tokens{1} );
        return
    end % if
end % for

end % constructorOutputName

function initials = chartInitials( chartName )
%CHARTINITIALS Return the uppercase letters from a chart class name.

arguments ( Input )
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    initials(1, 1) string
end % arguments ( Output )

characters = char( chartName );
initials = string( characters(isstrprop( characters, "upper" )) );

end % chartInitials

function description = lookupDescription( descriptions, chartName )
%LOOKUPDESCRIPTION Return the chart description.

arguments ( Input )
    descriptions containers.Map
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    description(1, 1) string
end % arguments ( Output )

if isKey( descriptions, char( chartName ) )
    description = string( descriptions( char( chartName ) ) );
else
    description = "Reference documentation for `" + chartName + "`.";
end % if

end % lookupDescription

function text = capitalizeFirstLetter( text )
%CAPITALIZEFIRSTLETTER Capitalize the first letter in text.

arguments ( Input )
    text(1, 1) string
end % arguments ( Input )

arguments ( Output )
    text(1, 1) string
end % arguments ( Output )

if strlength( text ) == 0
    return
end % if

firstLetter = extractBefore( text, 2 );
text = upper( firstLetter ) + extractAfter( text, 1 );

end % capitalizeFirstLetter

function overview = extractOverviewSummary( exampleFile )
%EXTRACTOVERVIEWSUMMARY Extract the first overview paragraph.

arguments ( Input )
    exampleFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    overview(:, 1) string
end % arguments ( Output )

overview = strings( 0, 1 );
if ~isfile( exampleFile )
    overview = "See the runnable example for chart usage details.";
    return
end % if

lines = readlines( exampleFile );
startIdx = find( strtrim( lines ) == "## Overview", 1, "first" );
if isempty( startIdx )
    overview = "See the runnable example for chart usage details.";
    return
end % if

for idx = startIdx + 1:numel( lines )
    line = strip( lines(idx) );
    if startsWith( line, "## " ) || startsWith( line, "!" )
        break
    elseif strlength( line ) == 0 && ~isempty( overview )
        break
    elseif strlength( line ) > 0
        overview(end + 1, 1) = line; %#ok<AGROW>
    end % if
end % for

if isempty( overview )
    overview = "See the runnable example for chart usage details.";
end % if

end % extractOverviewSummary

function examples = extractExampleSection( exampleFile )
%EXTRACTEXAMPLESECTION Extract example content from an example page.

arguments ( Input )
    exampleFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    examples(:, 1) string
end % arguments ( Output )

examples = "No example content is available.";
if ~isfile( exampleFile )
    return
end % if

lines = readlines( exampleFile );
startIdx = find( strtrim( lines ) == "## Examples", 1, "first" );
if isempty( startIdx ) || startIdx == numel( lines )
    return
end % if

examples = lines(startIdx + 1:end);
examples = stripBlankBoundaryLines( examples );
examples = fixExampleRelativeLinks( examples );

if isempty( examples )
    examples = "No example content is available.";
end % if

end % extractExampleSection

function lines = stripBlankBoundaryLines( lines )
%STRIPBLANKBOUNDARYLINES Remove leading and trailing blank lines.

arguments ( Input )
    lines(:, 1) string
end % arguments ( Input )

arguments ( Output )
    lines(:, 1) string
end % arguments ( Output )

while ~isempty( lines ) && strlength( strip( lines(1) ) ) == 0
    lines(1) = [];
end % while

while ~isempty( lines ) && strlength( strip( lines(end) ) ) == 0
    lines(end) = [];
end % while

end % stripBlankBoundaryLines

function rows = publicPropertyRows( classInfo, chartName )
%PUBLICPROPERTYROWS Create table rows for chart public properties.

arguments ( Input )
    classInfo(1, 1) meta.class
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    rows(:, 1) string
end % arguments ( Output )

rows = strings( 0, 1 );
for propertyInfo = classInfo.PropertyList.'
    if isDocumentedProperty( propertyInfo, chartName )
        rows(end + 1, 1) = propertyRow( propertyInfo ); %#ok<AGROW>
    end % if
end % for

if isempty( rows )
    rows = "| none | none | none | none | none |";
end % if

end % publicPropertyRows

function rows = publicMethodRows( classInfo, chartName )
%PUBLICMETHODROWS Create table rows for chart public methods.

arguments ( Input )
    classInfo(1, 1) meta.class
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    rows(:, 1) string
end % arguments ( Output )

rows = strings( 0, 1 );
for methodInfo = classInfo.MethodList.'
    if isDocumentedMethod( methodInfo, chartName )
        rows(end + 1, 1) = methodRow( methodInfo ); %#ok<AGROW>
    end % if
end % for

if isempty( rows )
    rows = "| none | none |";
end % if

end % publicMethodRows

function tf = isDocumentedProperty( propertyInfo, chartName )
%ISDOCUMENTEDPROPERTY True for chart-specific public properties.

arguments ( Input )
    propertyInfo(1, 1) meta.property
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    tf(1, 1) logical
end % arguments ( Output )

tf = isPublicAccess( propertyInfo.GetAccess ) && ...
    string( propertyInfo.DefiningClass.Name ) == chartName && ...
    ~propertyInfo.Hidden && ~propertyInfo.Constant;

end % isDocumentedProperty

function tf = isDocumentedMethod( methodInfo, chartName )
%ISDOCUMENTEDMETHOD True for chart-specific public methods.

arguments ( Input )
    methodInfo(1, 1) meta.method
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    tf(1, 1) logical
end % arguments ( Output )

name = string( methodInfo.Name );
tf = isPublicAccess( methodInfo.Access ) && ...
    string( methodInfo.DefiningClass.Name ) == chartName && ...
    ~methodInfo.Hidden && ~methodInfo.Static && ...
    name ~= chartName && ...
    ~startsWith( name, "get." ) && ...
    ~startsWith( name, "set." );

end % isDocumentedMethod

function row = propertyRow( propertyInfo )
%PROPERTYROW Create a Markdown table row for a property.

arguments ( Input )
    propertyInfo(1, 1) meta.property
end % arguments ( Input )

arguments ( Output )
    row(1, 1) string
end % arguments ( Output )

name = "`" + string( propertyInfo.Name ) + "`";
description = tableText( string( propertyInfo.Description ) );
if strlength( description ) == 0
    description = "No description available.";
end % if
type = tableText( propertyType( propertyInfo ) );
defaultValue = tableText( propertyDefaultValue( propertyInfo ) );
access = propertyAccess( propertyInfo );
row = "| " + name + " | " + description + " | " + type + ...
    " | " + defaultValue + " | " + access + " |";

end % propertyRow

function row = methodRow( methodInfo )
%METHODROW Create a Markdown table row for a method.

arguments ( Input )
    methodInfo(1, 1) meta.method
end % arguments ( Input )

arguments ( Output )
    row(1, 1) string
end % arguments ( Output )

name = "`" + string( methodInfo.Name ) + "`";
description = tableText( string( methodInfo.Description ) );
if strlength( description ) == 0
    description = "Call `" + string( methodInfo.Name ) + ...
        "` on the chart.";
end % if
row = "| " + name + " | " + description + " |";

end % methodRow

function tf = isPublicAccess( access )
%ISPUBLICACCESS True for public metadata access.

arguments ( Input )
    access
end % arguments ( Input )

arguments ( Output )
    tf(1, 1) logical
end % arguments ( Output )

tf = ischar( access ) && string( access ) == "public";

end % isPublicAccess

function type = propertyType( propertyInfo )
%PROPERTYTYPE Return a compact property type description.

arguments ( Input )
    propertyInfo(1, 1) meta.property
end % arguments ( Input )

arguments ( Output )
    type(1, 1) string
end % arguments ( Output )

type = "not specified";
validation = propertyInfo.Validation;
if ~isempty( validation ) && ~isempty( validation.Class )
    type = "`" + string( validation.Class.Name ) + "`";
end % if

end % propertyType

function defaultValue = propertyDefaultValue( propertyInfo )
%PROPERTYDEFAULTVALUE Return a compact default value description.

arguments ( Input )
    propertyInfo(1, 1) meta.property
end % arguments ( Input )

arguments ( Output )
    defaultValue(1, 1) string
end % arguments ( Output )

if ~propertyInfo.HasDefault
    defaultValue = "none";
else
    defaultValue = "`" + valueToText( propertyInfo.DefaultValue ) + "`";
end % if

end % propertyDefaultValue

function access = propertyAccess( propertyInfo )
%PROPERTYACCESS Return public or read-only access text.

arguments ( Input )
    propertyInfo(1, 1) meta.property
end % arguments ( Input )

arguments ( Output )
    access(1, 1) string
end % arguments ( Output )

if isPublicAccess( propertyInfo.SetAccess )
    access = "public";
else
    access = "read-only";
end % if

end % propertyAccess

function text = valueToText( value )
%VALUETOTEXT Convert a MATLAB value to compact display text.

arguments ( Input )
    value
end % arguments ( Input )

arguments ( Output )
    text(1, 1) string
end % arguments ( Output )

if isa( value, "matlab.lang.OnOffSwitchState" ) || isenum( value )
    text = """" + string( value ) + """";
elseif isstring( value )
    text = join( """" + value + """", ", " );
elseif ischar( value )
    text = """" + string( value ) + """";
elseif isnumeric( value ) || islogical( value )
    if numel( value ) <= 12
        text = string( mat2str( value ) );
    else
        text = join( string( size( value ) ), "x" ) + " " + ...
            class( value );
    end % if
elseif isobject( value )
    text = class( value ) + " object";
else
    text = class( value ) + " value";
end % if

if strlength( text ) == 0
    text = "[]";
end % if

end % valueToText

function text = tableText( text )
%TABLETEXT Escape text for Markdown tables.

arguments ( Input )
    text(1, 1) string
end % arguments ( Input )

arguments ( Output )
    text(1, 1) string
end % arguments ( Output )

text = replace( text, "|", "\|" );
text = replace( text, newline(), " " );

end % tableText

function imageLink = extractImageLink( exampleFile )
%EXTRACTIMAGELINK Extract the first image from an example page.

arguments ( Input )
    exampleFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    imageLink(1, 1) string
end % arguments ( Output )

imageLink = "";
if ~isfile( exampleFile )
    return
end % if

lines = readlines( exampleFile );
for idx = 1:numel( lines )
    line = strip( lines(idx) );
    if startsWith( line, "![" )
        imageLink = fixExampleRelativeLinks( line );
        return
    end % if
end % for

end % extractImageLink

function listing = codeListing( file )
%CODELISTING Return a non-executable Markdown code listing.

arguments ( Input )
    file(1, 1) string
end % arguments ( Input )

arguments ( Output )
    listing(:, 1) string
end % arguments ( Output )

if isfile( file )
    content = readlines( file );
else
    content = "Missing file: " + file;
end % if

listing = [
    "````text"
    content
    "````"];

end % codeListing

function testFile = findTestFile( testFolder, chartName )
%FINDTESTFILE Find the chart-specific test file, if it exists.

arguments ( Input )
    testFolder(1, 1) string
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    testFile(1, 1) string
end % arguments ( Output )

testFile = "";
candidate = fullfile( testFolder, "t" + chartName + ".m" );
if isfile( candidate )
    testFile = candidate;
    return
end % if

switch chartName
    case "ScatterFitChart"
        candidate = fullfile( testFolder, "tScatterFit.m" );
    case "WaterfallChart"
        candidate = fullfile( testFolder, "tWaterfallChart.m" );
    otherwise
        candidate = "";
end % switch

if strlength( candidate ) > 0 && isfile( candidate )
    testFile = candidate;
end % if

end % findTestFile

function lines = fixExampleRelativeLinks( lines )
%FIXEXAMPLERELATIVELINKS Update example-relative image links.

arguments ( Input )
    lines(:, 1) string
end % arguments ( Input )

arguments ( Output )
    lines(:, 1) string
end % arguments ( Output )

lines = replace( lines, "](./images/", "](../examples/images/" );
lines = replace( lines, "](images/", "](../examples/images/" );

end % fixExampleRelativeLinks

function writeTextFile( file, lines )
%WRITETEXTFILE Write text lines to a UTF-8 file.

arguments ( Input )
    file(1, 1) string
    lines(:, 1) string
end % arguments ( Input )

text = strjoin( lines, newline() );
fileID = fopen( file, "w", "n", "UTF-8" );
cleanup = onCleanup( @() fclose( fileID ) );
fprintf( fileID, "%s\n", text );

end % writeTextFile

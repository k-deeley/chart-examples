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
outputRoot = fullfile( docRoot, "charts" );
outputFolders = chartOutputFolders( outputRoot );

ensureOutputFolders( outputFolders )

chartInfo = dir( fullfile( chartFolder, "*.m" ) );
chartNames = sort( erase( string( {chartInfo.name} ), ".m" ) ).';
descriptions = getChartDescriptions();

generatedFiles = strings( 0, 1 );
generatedFiles(end + 1, 1) = writeChartIndex( ...
    outputRoot, chartNames, descriptions );
generatedFiles(end + 1, 1) = writeHelpToc( ...
    docRoot, chartNames, testFolder );

for chartIdx = 1 : numel( chartNames )
    chartName = chartNames(chartIdx);
    newFiles = writeChartPages( ...
        outputFolders, chartName, descriptions, chartFolder, ...
        exampleFolder, testFolder );
    generatedFiles = [generatedFiles; newFiles]; %#ok<AGROW>
end % for

fprintf( 1, "[+] Generated %d chart reference pages.\n", ...
    numel( generatedFiles ) )

end % generateChartReferencePages

function outputFolders = chartOutputFolders( outputRoot )
%CHARTOUTPUTFOLDERS Return chart documentation output folders.

arguments ( Input )
    outputRoot(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFolders(1, 1) struct
end % arguments ( Output )

outputFolders.Root = outputRoot;
outputFolders.Landing = fullfile( outputRoot, "landing" );
outputFolders.References = fullfile( outputRoot, "references" );
outputFolders.Source = fullfile( outputRoot, "source" );
outputFolders.Tests = fullfile( outputRoot, "tests" );
outputFolders.Images = fullfile( outputRoot, "images" );

end % chartOutputFolders

function ensureOutputFolders( outputFolders )
%ENSUREOUTPUTFOLDERS Create chart documentation output folders.

arguments ( Input )
    outputFolders(1, 1) struct
end % arguments ( Input )

folderNames = [
    "Root"
    "Landing"
    "References"
    "Source"
    "Tests"
    "Images"];

for folderName = folderNames.'
    folder = outputFolders.(folderName);
    if ~isfolder( folder )
        mkdir( folder )
    end % if
end % for

end % ensureOutputFolders

function descriptions = getChartDescriptions()
%GETCHARTDESCRIPTIONS Return chart reference descriptions.

arguments ( Output )
    descriptions containers.Map
end % arguments ( Output )

chartNames = [
    "AircraftChart"
    "AnnulusChart"
    "CircularNetFlowChart"
    "ClockChart"
    "CylinderChart"
    "EdgeworthBowleyChart"
    "GraphicsHierarchyChart"
    "ImpliedVolatilityChart"
    "InductionMotorChart"
    "LineGradientChart"
    "LineSelectorChart"
    "PolarChart"
    "RadarScope"
    "RangefinderChart"
    "SankeyChart"
    "ScatterBoxChart"
    "ScatterDensityChart"
    "ScatterFitChart"
    "SettlementChart"
    "SignalTraceChart"
    "SnailTrailChart"
    "SpiderChart"
    "TernaryChart"
    "ValueAtRiskChart"
    "WaterfallChart"
    "WindRoseChart"];

chartDescriptions = [
    "visualize an aircraft and modify its roll, pitch, and yaw."
    "visualize relative proportions in a data vector using an annulus."
    "show directed flow relationships between categories."
    "display an analog clock with scheduled updates."
    "plot data using stacked cylinders."
    "plot utility curves and a Pareto-efficient contract curve."
    "visualize the graphics hierarchy below a graphics object."
    "plot an implied volatility surface."
    "visualize induction motor characteristics."
    "plot a variable-color curve."
    "select and highlight one line from a collection."
    "plot circular data on a polar chart."
    "plot radar blips and issue proximity alerts."
    "show median crossover and marginal adjacent values."
    "illustrate flow between states."
    "combine a scatter plot with marginal box plots."
    "use color to show relative point density."
    "manage scattered data with a best-fit line."
    "plot in-the-money option prices against strike prices."
    "plot non-overlapping signal traces."
    "plot excess returns against tracking errors."
    "compare values from distinct measurements on a web."
    "plot three variables that sum to a constant."
    "show a return distribution and value-at-risk metrics."
    "show the cumulative evolution of an initial value."
    "display wind speed and direction on a polar histogram."];

descriptions = containers.Map( cellstr( chartNames ), ...
    cellstr( chartDescriptions ) );

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
    displayName = chartDisplayName( chartName );
    lines(end + 1, 1) = "* [" + displayName + "](" + ...
        "landing/" + chartName + ".md) - " + ...
        description; %#ok<AGROW>
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
    displayName = chartDisplayName( chartName );
    lines(end + 1, 1) = "    * [" + displayName + "](charts/" + ...
        "landing/" + chartName + ".md)"; %#ok<AGROW>
    lines(end + 1, 1) = "      * [Class Documentation and " + ...
        "Examples](charts/references/" + chartName + ...
        "ClassReference.md)"; %#ok<AGROW>
    lines(end + 1, 1) = "      * [Source Code " + ...
        "Listing](charts/source/" + chartName + ...
        "SourceCode.md)"; %#ok<AGROW>
    if strlength( testFile ) > 0
        lines(end + 1, 1) = "      * [Test Code " + ...
            "Listing](charts/tests/" + chartName + ...
            "UnitTest.md)"; %#ok<AGROW>
    end % if
end % for

outputFile = fullfile( docRoot, "helptoc.md" );
writeTextFile( outputFile, lines )

end % writeHelpToc

function outputFiles = writeChartPages( outputFolders, chartName, ...
        descriptions, chartFolder, exampleFolder, testFolder )
%WRITECHARTPAGES Write chart reference pages.

arguments ( Input )
    outputFolders(1, 1) struct
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
    outputFolders, chartName, description, exampleFile, testFile );
outputFiles(2) = writeClassReferencePage( ...
    outputFolders, chartName, description, exampleFile, testFile );
outputFiles(3) = writeSourceCodePage( ...
    outputFolders, chartName, sourceFile );
if strlength( testFile ) > 0
    outputFiles(end + 1, 1) = writeUnitTestPage( ...
        outputFolders, chartName, testFile );
end % if

end % writeChartPages

function outputFile = writeChartPage( ...
        outputFolders, chartName, description, exampleFile, testFile )
%WRITECHARTPAGE Write one chart reference landing page.

arguments ( Input )
    outputFolders(1, 1) struct
    chartName(1, 1) string
    description(1, 1) string
    exampleFile(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# " + chartDisplayName( chartName )
    ""
    capitalizeFirstLetter( description )
    ""];

imageLink = extractImageLink( exampleFile, "../images" );
if strlength( imageLink ) == 0
    imageLink = chartImageLink( ...
        outputFolders.Images, "../images", chartName );
end % if
if strlength( imageLink ) > 0
    lines = [lines; imageLink; ""];
end % if

lines = [
    lines
    "* [Class Documentation and Examples](" + ...
    "../references/" + chartName + "ClassReference.md)"
    "* [Source Code Listing](../source/" + ...
    chartName + "SourceCode.md)"];
if strlength( testFile ) > 0
    lines = [
        lines
        "* [Test Code Listing](../tests/" + chartName + ...
        "UnitTest.md)"];
else
    lines = [
        lines
        "* No chart-specific test code listing exists."
        ""];
end % if

outputFile = fullfile( outputFolders.Landing, chartName + ".md" );
writeTextFile( outputFile, lines )

end % writeChartPage

function outputFile = writeClassReferencePage( ...
        outputFolders, chartName, description, exampleFile, testFile )
%WRITECLASSREFERENCEPAGE Write one chart class reference page.

arguments ( Input )
    outputFolders(1, 1) struct
    chartName(1, 1) string
    description(1, 1) string
    exampleFile(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

outputFile = fullfile( ...
    outputFolders.References, chartName + "ClassReference.md" );
classInfo = meta.class.fromName( chartName );
exampleSections = extractExampleSections( exampleFile, outputFile );
propertyRows = publicPropertyRows( classInfo, chartName );
methodRows = publicMethodRows( classInfo, chartName );
outputName = constructorOutputName( chartName, exampleFile );

lines = [
    "# `" + chartName + "`"
    ""
    capitalizeFirstLetter( description )
    ""
    exampleSections.Overview
    ""
    "## Syntax"
    ""
    "```matlab"
    chartName + "()"
    chartName + "(name, value, ...)"
    outputName + " = " + chartName + "(name, value, ...) "
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
    exampleSections.Documentation
    ""
    exampleSections.Examples
    ""
    "## See Also"
    ""
    "* [" + chartDisplayName( chartName ) + "](../landing/" + ...
    chartName + ".md)"
    "* [Source Code Listing](../source/" + ...
    chartName + "SourceCode.md)"];

if strlength( testFile ) > 0
    lines = [
        lines
        "* [Test Code Listing](../tests/" + chartName + ...
        "UnitTest.md)"];
end % if

lines = [
    lines
    "* [Chart Reference](../ChartsIndex.md)"
    ""];

writeTextFile( outputFile, lines )

end % writeClassReferencePage

function outputFile = writeSourceCodePage( outputFolders, chartName, ...
        sourceFile )
%WRITESOURCECODEPAGE Write one chart source code listing page.

arguments ( Input )
    outputFolders(1, 1) struct
    chartName(1, 1) string
    sourceFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

lines = [
    "# `" + chartName + "` Source Code"
    ""
    "Source file: `" + chartName + ".m`."
    ""
    codeListing( sourceFile )
    ""
    "## See Also"
    ""
    "* [" + chartDisplayName( chartName ) + "](../landing/" + ...
    chartName + ".md)"
    "* [Chart Reference](../ChartsIndex.md)"
    ""];

outputFile = fullfile( ...
    outputFolders.Source, chartName + "SourceCode.md" );
writeTextFile( outputFile, lines )

end % writeSourceCodePage

function outputFile = writeUnitTestPage( ...
        outputFolders, chartName, testFile )
%WRITEUNITTESTPAGE Write one chart unit test listing page.

arguments ( Input )
    outputFolders(1, 1) struct
    chartName(1, 1) string
    testFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    outputFile(1, 1) string
end % arguments ( Output )

[~, testName, ext] = fileparts( testFile );
lines = [
    "# `" + chartName + "` Test Class"
    ""
    "Test file: `" + testName + ext + "`."
    ""
    codeListing( testFile )
    ""
    "## See Also"
    ""
    "* [" + chartDisplayName( chartName ) + "](../landing/" + ...
    chartName + ".md)"
    "* [Chart Reference](../ChartsIndex.md)"
    ""];

outputFile = fullfile( outputFolders.Tests, chartName + "UnitTest.md" );
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

function displayName = chartDisplayName( chartName )
%CHARTDISPLAYNAME Convert a chart class name to a display name.

arguments ( Input )
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    displayName(1, 1) string
end % arguments ( Output )

words = regexp( chartName, "[A-Z][a-z0-9]*", "match" );
displayName = strjoin( string( words ), " " );

end % chartDisplayName

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

function imageLink = extractImageLink( exampleFile, imageLinkFolder )
%EXTRACTIMAGELINK Extract the first image from an example page.

arguments ( Input )
    exampleFile(1, 1) string
    imageLinkFolder(1, 1) string
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
        imageLink = fixChartRelativeLinks( line, imageLinkFolder );
        return
    end % if
end % for

end % extractImageLink

function imageLink = chartImageLink( ...
        imageFolder, imageLinkFolder, chartName )
%CHARTIMAGELINK Return the local chart image link, if it exists.

arguments ( Input )
    imageFolder(1, 1) string
    imageLinkFolder(1, 1) string
    chartName(1, 1) string
end % arguments ( Input )

arguments ( Output )
    imageLink(1, 1) string
end % arguments ( Output )

imageLink = "";
extensions = [".svg", ".png"];
for extension = extensions
    imageFile = fullfile( imageFolder, chartName + extension );
    if isfile( imageFile )
        imageLink = "![](" + imageLinkFolder + "/" + ...
            chartName + extension + ")";
        return
    end % if
end % for

end % chartImageLink

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
    copyrightLine = contains( content, "Copyright" ) & ...
        contains( content, "The MathWorks, Inc." );
    content(copyrightLine) = [];
else
    content = "Missing file: " + file;
end % if

listing = [
    "````text "
    content
    "````"];

end % codeListing

function sections = extractExampleSections( exampleFile, fallbackFile )
%EXTRACTEXAMPLESECTIONS Extract embedded example page sections.

arguments ( Input )
    exampleFile(1, 1) string
    fallbackFile(1, 1) string
end % arguments ( Input )

arguments ( Output )
    sections(1, 1) struct
end % arguments ( Output )

if isfile( exampleFile )
    lines = readlines( exampleFile );
    overviewStop = ["## Documentation", "## Examples"];
elseif isfile( fallbackFile )
    lines = readlines( fallbackFile );
    overviewStop = "## Syntax";
else
    lines = strings( 0, 1 );
    overviewStop = ["## Documentation", "## Examples"];
end % if

sections.Overview = sectionLines( ...
    lines, "## Overview", overviewStop, ...
    "## Overview" + newline() + ...
    "See the runnable example for chart usage details." );
sections.Documentation = sectionLines( ...
    lines, "## Documentation", "## Examples", ...
    "## Documentation" + newline() + ...
    "No related documentation is available." );
sections.Examples = sectionLines( ...
    lines, "## Examples", "## See Also", ...
    "## Examples" + newline() + ...
    "No example content is available." );

sections.Overview = fixChartRelativeLinks( ...
    sections.Overview, "../images" );
sections.Documentation = fixChartRelativeLinks( ...
    sections.Documentation, "../images" );
sections.Examples = fixChartRelativeLinks( ...
    sections.Examples, "../images" );

end % extractExampleSections

function section = sectionLines( lines, heading, stopHeadings, fallback )
%SECTIONLINES Extract one Markdown section, including its heading.

arguments ( Input )
    lines(:, 1) string
    heading(1, 1) string
    stopHeadings(1, :) string
    fallback(1, 1) string
end % arguments ( Input )

arguments ( Output )
    section(:, 1) string
end % arguments ( Output )

startIdx = find( strtrim( lines ) == heading, 1, "first" );
if isempty( startIdx )
    section = splitlines( fallback );
    return
end % if

stopIdx = numel( lines ) + 1;
for idx = startIdx + 1:numel( lines )
    line = strtrim( lines(idx) );
    if any( startsWith( line, stopHeadings ) )
        stopIdx = idx;
        break
    end % if
end % for

section = stripBlankBoundaryLines( lines(startIdx:stopIdx - 1) );

end % sectionLines

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
end % if

end % findTestFile

function lines = fixChartRelativeLinks( lines, imageLinkFolder )
%FIXCHARTRELATIVELINKS Update image links for chart pages.

arguments ( Input )
    lines(:, 1) string
    imageLinkFolder(1, 1) string
end % arguments ( Input )

arguments ( Output )
    lines(:, 1) string
end % arguments ( Output )

replacement = "](" + imageLinkFolder + "/";
lines = replace( lines, "](./images/", replacement );
lines = replace( lines, "](images/", replacement );
lines = replace( lines, "](../charts/images/", replacement );
lines = replace( lines, "](../charts/", replacement );
lines = replace( lines, "](../examples/images/", replacement );

end % fixChartRelativeLinks

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

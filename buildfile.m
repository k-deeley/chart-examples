function plan = buildfile()
%BUILDFILE Chart Development Toolbox build file.

% Copyright 2024-2025 The MathWorks, Inc.

% Define the build plan.
plan = buildplan( localfunctions() );

% Set the package task to run by default.
plan.DefaultTasks = "package";

% Add a test task to run the unit tests for the project. Generate and save
% a coverage report. This build task is optional.
%projectRoot = plan.RootFolder;
%testFolder = fullfile( projectRoot, "charts", "tests" );
%codeFolder = fullfile( projectRoot, "tbx", "charts"  );
% plan("test") = matlab.buildtool.tasks.TestTask( testFolder, ...
%     "Strict", true, ...
%     "Description", "Assert that all tests across the project pass.", ...
%     "SourceFiles", codeFolder, ...
%     "CodeCoverageResults", "reports/Coverage.html", ...
%     "OutputDetail", "none" );

% The test task depends on the check task.
%plan("test").Dependencies = "check";

% The doc task depends on the check task.
plan("doc").Dependencies = "check";

% Skip the doc task if the charts, examples, and doc files are up to date.
plan("doc").Inputs = [
    fullfile( chartsRoot(), "charts" );
    fullfile( chartsRoot(), "examples" );
    fullfile( chartsRoot(), "doc" )];

% Obfuscate the required files.
appFolder = fullfile( chartsRoot(), "app" );
sourceFile = fullfile( appFolder, "ChartBrowserLauncher.m" );
plan("pcode") = matlab.buildtool.tasks.PcodeTask( ...
    sourceFile, appFolder, ...
    "Description", "Obfuscate the required code files.", ...
    "Dependencies", "doc" );

% The package task depends on the p-code task.
plan("package").Dependencies = "pcode";

end % buildfile

function checkTask( context )
% Check the source code and project for any issues.

% Set the project root as the folder in which to check for any static code
% issues.
projectRoot = context.Plan.RootFolder;
codeIssuesTask = matlab.buildtool.tasks.CodeIssuesTask( projectRoot, ...
    "IncludeSubfolders", true, ...
    "Configuration", "factory", ...
    "Description", ...
    "Assert that there are no code issues in the project.", ...
    "WarningThreshold", 0 );
codeIssuesTask.analyze( context )

% Update the project dependencies.
prj = currentProject();
prj.updateDependencies()

% Run the checks.
checkResults = table( prj.runChecks() );

% Log any failed checks.
passed = checkResults.Passed;
notPassed = ~passed;
if any( notPassed )
    disp( checkResults(notPassed, :) )
else
    fprintf( "** All project checks passed.\n\n" )
end % if

% Check that all checks have passed.
assert( all( passed ), "buildfile:ProjectIssue", ...
    "At least one project check has failed. " + ...
    "Resolve the failures shown above to continue." )

end % checkTask

function docTask( context )
% Build the documentation and examples.

% Publish the chart classes as HTML documents.
chartsFolder = context.Task.Inputs(1).Path;
chartsInfo = struct2table( dir( fullfile( chartsFolder, "*.m" ) ) );
chartNames = string( chartsInfo.name );
chartFullPaths = fullfile( chartsFolder, chartNames );
chartNames = erase( chartNames, ".m" );
htmlOutputFolder = fullfile( chartsRoot(), "app", "html", "charts" );

for chartIdx = 1 : numel( chartNames )

    % Export the chart classdef file to an HTML document.
    publishedFile = publish( chartFullPaths(chartIdx), ...
        "format", "html", ...
        "outputDir", htmlOutputFolder, ...
        "evalCode", false );

    % Open it for editing.
    htmlFileContents = fileread( publishedFile );

    % Insert the JavaScript code.
    jsFile = fullfile( chartsRoot(), "app", "html", ...
        "respondToThemeChanges.js" );
    jsCode = fileread( jsFile );
    htmlFileContents = insertBefore( htmlFileContents, "</body>", ...
        "<script type=""text/javascript"">" + jsCode + "</script>" );

    % Replace the file contents.
    fileID = fopen( publishedFile, "w" );
    fprintf( fileID, "%s", htmlFileContents );
    fclose( fileID ); 

    % Report progress.
    fprintf( 1, "[+] %s\n", publishedFile )

end % for

% Publish the examples as HTML documents.
examplesFolder = context.Task.Inputs(2).Path;
examplesInfo = struct2table( dir( fullfile( ...
    examplesFolder, "*Examples.m" ) ) );
exampleNames = string( examplesInfo.name );
exampleFullPaths = fullfile( examplesFolder, exampleNames );
exampleNames = erase( exampleNames, ".m" );
htmlOutputFolder = fullfile( chartsRoot(), "app", "html", "examples" );

for exampleIdx = 1 : numel( exampleNames )

    % Export the script to HTML.
    exportName = fullfile( htmlOutputFolder, ...
        exampleNames(exampleIdx) + ".html" );
    export( exampleFullPaths(exampleIdx), exportName, ...
        "Format", "html", ...
        "Run", false );

    % Activate the hyperlinks.
    activateLinks( exportName )

    % Report progress.
    fprintf( 1, "[+] %s\n", exportName )

end % for

% Write down the doc source and output folders.
docFolder = context.Task.Inputs(3).Path;
htmlOutputFolder = fullfile( chartsRoot(), "app", "html", "doc" );

% Publish the documentation files.
docInfo = struct2table( dir( fullfile( docFolder, "*.m" ) ) );
docFilenames = string( docInfo.name );
for fileIdx = 1 : numel( docFilenames )
    exportToHTML( docFilenames(fileIdx) )
end % for

    function exportToHTML( scriptName )
        %EXPORTTOHTML Export the given script to HTML format.

        scriptFullPath = fullfile( docFolder, scriptName );
        [~, scriptNameNoExt] = fileparts( scriptName );
        exportName = fullfile( htmlOutputFolder, ...
            scriptNameNoExt + ".html" );
        export( scriptFullPath, exportName, ...
            "Format", "html", ...
            "Run", false );
        activateLinks( exportName )

    end % exportToHTML

end % docTask

function packageTask( context )
% Package the Chart Development Toolbox.

% Toolbox short name.
toolboxShortName = "charts";

% Project root directory.
projectRoot = context.Plan.RootFolder;

% Import and tweak the toolbox metadata.
toolboxJSON = fullfile( projectRoot, toolboxShortName + ".json" );
meta = jsondecode( fileread( toolboxJSON ) );
meta.ToolboxMatlabPath = fullfile( projectRoot, meta.ToolboxMatlabPath );
meta.ToolboxFolder = fullfile( projectRoot, meta.ToolboxFolder );
meta.ToolboxImageFile = fullfile( projectRoot, meta.ToolboxImageFile );
versionString = feval( @(s) s(1).Version, ...
    ver( toolboxShortName ) ); %#ok<FVAL>
meta.ToolboxVersion = versionString;
meta.ToolboxGettingStartedGuide = fullfile( projectRoot, ...
    meta.ToolboxGettingStartedGuide );
mltbx = fullfile( projectRoot, ...
    meta.ToolboxName + " " + versionString + ".mltbx" );
meta.OutputFile = mltbx;

% Define the toolbox packaging options.
toolboxFolder = meta.ToolboxFolder;
toolboxID = meta.Identifier;
meta = rmfield( meta, ["Identifier", "ToolboxFolder"] );
opts = matlab.addons.toolbox.ToolboxOptions( ...
    toolboxFolder, toolboxID, meta );

% Remove unnecessary files.
tf = endsWith( opts.ToolboxFiles, "ChartBrowserLauncher.m" ) | ...
    endsWith( opts.ToolboxFiles, ...
    "app\images\" + lettersPattern() + "Chart.png" );
opts.ToolboxFiles(tf) = [];

% Package the toolbox.
matlab.addons.toolbox.packageToolbox( opts )
fprintf( 1, "[+] %s\n", opts.OutputFile )

% Add the license.
licenseText = fileread( fullfile( projectRoot, "LICENSE.txt" ) );
mlAddonSetLicense( char( opts.OutputFile ), ...
    struct( "type", 'BSD', "text", licenseText ) );

end % packageTask

function activateLinks( file )
%ACTIVATELINKS Convert the Live Script hyperlinks to JavaScript-enabled
%links within the specified HTML file.

arguments ( Input )
    file(1, 1) string {mustBeFile}
end % arguments ( Input )

% Read the file contents.
htmlFileContents = string( fileread( file ) );

% Replace the commands within the anchors.

% Extract the anchors.
anchors = extractBetween( htmlFileContents, "<a href = ""matlab:", ">", ...
    "Boundaries", "inclusive" );

% Extract the commands.
commands = extractBetween( anchors, """", """" );

% Format the JavaScript-enabled anchors.
replacementAnchors = "<a href = ""#"" onclick=""handleClick(" + ...
    "'" + commands + "'" + "); return false;"">";

% Replace the original anchors with the new anchors.
for k = 1 : numel( anchors )
    htmlFileContents = replace( htmlFileContents, ...
        anchors(k), replacementAnchors(k) );
end % for

% Insert the JavaScript block.
jsFile = fullfile( chartsRoot(), "app", "html", "activateLinks.js" );
jsCode = fileread( jsFile );
htmlFileContents = insertBefore( htmlFileContents, "</body>", ...
    "<script type = ""text/javascript"">" + jsCode + "</script>" );

% Replace the file contents.
fileID = fopen( file, "w" );
fprintf( fileID, "%s", htmlFileContents );
fclose( fileID );

end % activateLinks
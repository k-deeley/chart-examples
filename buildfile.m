function plan = buildfile()
%BUILDFILE Chart Examples build file.

% Copyright 2024-2026 The MathWorks, Inc.

% Define the build plan.
plan = buildplan( localfunctions() );

% Folders of interest.
prj = plan.RootFolder;
api = fullfile( prj, "tbx" );
tests = fullfile( prj, "tbx", tbxname(), "tests" );
charts = fullfile( prj, "tbx", tbxname(), tbxname() );
doc = fullfile( prj, "tbx", tbxname() + "doc" );

% Set the package task to run by default.
plan.DefaultTasks = "package";

% Add the clean task.
plan("clean") = matlab.buildtool.tasks.CleanTask();

% Add the check task group.
plan("check:code") = matlab.buildtool.tasks.CodeIssuesTask( prj, ...
    "IncludeSubfolders", true, ...
    "Configuration", "factory", ...
    "Description", ...
    "Assert that there are no code issues in the project.", ...
    "ErrorThreshold", 0, ...
    "WarningThreshold", 0, ...
    "InfoThreshold", 0 );

plan("check:project") = matlab.buildtool.Task( ...
    "Description", "Run MATLAB project checks.", ...
    "Actions", @checkProject, ...
    "Inputs", api );

% Add a test task to run the unit tests for the project. Generate and save
% a coverage report.
plan("test") = matlab.buildtool.tasks.TestTask( tests, ...
    "Dependencies", "check", ...
    "Strict", true, ...
    "RunOnlyImpactedTests", true, ...
    "Description", "Assert that all impacted tests " + ...
    "across the project pass.", ...
    "SourceFiles", charts, ...
    "TestResults", "reports/Results.html");    
plan("test").addCodeCoverage( "reports/Coverage.html", ...
    "MetricLevel", "mcdc" );

% The doc task depends on the test task.
plan("doc").Dependencies = "test";

% Skip the doc task if the documentation files are up to date.
plan("doc").Inputs = [doc; charts; tests];
plan("doc").Outputs = [
    fullfile( doc, "**", "*.html" );
    fullfile( doc, "*.xml" );
    fullfile( doc, "resources" );
    fullfile( doc, "helpsearch-v*" )];

% Add the package task (this depends on the doc task).
plan("package") = matlab.buildtool.tasks.PackageTask( ...
    "Chart_Examples", ...
    "Dependencies", "doc" );
plan("package").Actions(end+1) = @versionPackage;

end % buildfile

function name = tbxname()
%TBXNAME Toolbox short name.

name = "charts";

end % tbxname

function checkProject( ~ )
% Check the source code and project for any issues.

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

end % checkProject

function docTask( context )
% Build the documentation.

% Generate the chart reference pages.
docFolder = context.Task.Inputs(1).Path;
generatedMarkdownFiles = generateChartReferencePages();

% Convert the Markdown files to HTML.
markdownInfo = dir( fullfile( docFolder, "**", "*.md" ) );
markdownFiles = fullfile( string( {markdownInfo.folder} ), ...
    string( {markdownInfo.name} ) ).';
htmlFiles = docconvert( markdownFiles, ...
    "Theme", "light", ...
    "Root", docFolder );
fprintf( 1, "** Converted Markdown documentation to HTML.\n" )

% Insert the MATLAB output.
docrun( htmlFiles, "Theme", "light", "FigureSize", [600, 400] )
fprintf( 1, "** Inserted MATLAB output into doc.\n" )

% Build the doc index.
docindex( docFolder )
fprintf( 1, "** Indexed documentation.\n" )

addGeneratedFilesToProject( generatedMarkdownFiles )

end % docTask

function addGeneratedFilesToProject( files )
%ADDGENERATEDFILESTOPROJECT Add generated files to the current project.

arguments ( Input )
    files(1, :) string
end % arguments ( Input )

prj = currentProject();
projectFiles = string( {prj.Files.Path} );
for file = files
    if isfile( file ) && ~any( projectFiles == file )
        addFile( prj, file );
    end % if
end % for

end % addGeneratedFilesToProject

function versionPackage( ~ )
%VERSIONPACKAGE Ensure consistency between version sources.

v = ver( tbxname() );
versionName = v(1).Name;
versionString = v(1).Version;

% Check package version for consistency.
toml = string( splitlines( fileread( "matlab.toml" ) ) );
versionLine = toml(startsWith( toml, "version = " ));
tomlVersion = strip( extractAfter( versionLine, "version = " ), ...
    "both", """" );
assert( versionString == tomlVersion, ...
    "build:package:VersionPackageMismatch", ...
    "%s version %s (from Contents.m) does not " + ...
    "match the package version %s (in matlab.toml).", ...
    versionName, versionString, tomlVersion )

% Check version and tag compatibility for release
if strcmp( getenv( "GITHUB_ACTIONS" ), "true" )    
    ref = string( getenv( "GITHUB_REF" ) );
    gitTagNumber = extractAfter( ref, "refs/tags/v" );
    assert( versionString == gitTagNumber, ...
        "build:package:VersionTagMismatch", ...
        "%s package version %s (from Contents.m) does not " + ...
        "match the current Git tag number (%s).", ...
        versionName, versionString, gitTagNumber )    
end % if

end % versionPackage
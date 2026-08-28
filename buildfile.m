function plan = buildfile()
%BUILDFILE Chart Examples build file.

% Copyright 2024-2026 The MathWorks, Inc.

% Define the build plan.
plan = buildplan( localfunctions() );

% Set the package task to run by default.
plan.DefaultTasks = "package";

% Add the clean task.
plan("clean") = matlab.buildtool.tasks.CleanTask();

% Add the package task.
plan("package") = matlab.buildtool.tasks.PackageTask( "Chart_Examples" );

% Add a test task to run the unit tests for the project. Generate and save
% a coverage report.
projectRoot = plan.RootFolder;
testFolder = fullfile( projectRoot, "tbx", "charts", "tests" );
codeFolder = fullfile( projectRoot, "tbx", "charts", "charts"  );
plan("test") = matlab.buildtool.tasks.TestTask( testFolder, ...
    "Strict", true, ...
    "RunOnlyImpactedTests", true, ...
    "Description", "Assert that all impacted tests " + ...
    "across the project pass.", ...
    "SourceFiles", codeFolder, ...
    "TestResults", "reports/Results.html");    
plan("test").addCodeCoverage( "reports/Coverage.html", ...
    "MetricLevel", "mcdc" );

% The test task depends on the check task.
plan("test").Dependencies = "check";

% The doc task depends on the test task.
plan("doc").Dependencies = "test";

% Skip the doc task if the documentation files are up to date.
docFolder = fullfile( projectRoot, "tbx", "chartsdoc" );
plan("doc").Inputs = docFolder;
plan("doc").Outputs = [
    fullfile( docFolder, "**", "*.html" );
    fullfile( docFolder, "*.xml" );
    fullfile( docFolder, "resources" );
    fullfile( docFolder, "helpsearch-v*" )];

% The package task depends on the doc task.
plan("package").Dependencies = "doc";

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
    "WarningThreshold", 0, ...
    "InfoThreshold", 0 );
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
% Build the documentation.

docFolder = context.Task.Inputs(1).Path;
generatedMarkdownFiles = generateChartReferencePages();
markdownInfo = dir( fullfile( docFolder, "**", "*.md" ) );
markdownFiles = fullfile( string( {markdownInfo.folder} ), ...
    string( {markdownInfo.name} ) ).';
exampleFolder = fullfile( docFolder, "examples" ) + filesep();
markdownFiles = markdownFiles( ~startsWith( markdownFiles, ...
    exampleFolder ) );

htmlFiles = docconvert( markdownFiles, ...
    "Theme", "light", ...
    "Root", docFolder );
fprintf( 1, "** Converted Markdown documentation to HTML.\n" )

docrun( htmlFiles, "Theme", "light", "FigureSize", [600, 400] )
fprintf( 1, "** Inserted MATLAB output into doc.\n" )

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

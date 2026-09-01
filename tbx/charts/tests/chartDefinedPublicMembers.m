function [propertyNames, settableProperties, methodNames] = ...
        chartDefinedPublicMembers( chart )
%CHARTDEFINEDPUBLICMEMBERS List chart-defined public members.

arguments ( Input )
    chart(1, 1) {mustBeA( chart, ...
        ["matlab.graphics.chartcontainer.ChartContainer", ...
        "matlab.ui.componentcontainer.ComponentContainer"] )}
end % arguments ( Input )

mc = metaclass( chart );
chartClass = class( chart );
propertyNames = strings( 0, 1 );
settableProperties = strings( 0, 1 );
methodNames = strings( 0, 1 );

for propertyInfo = mc.PropertyList.'
    if isChartDefinedPublicProperty( propertyInfo, chartClass )
        propertyNames(end+1, 1) = string( propertyInfo.Name ); %#ok<AGROW>
        if isPublicAccess( propertyInfo.SetAccess ) && ...
                ~propertyInfo.Constant
            settableProperties(end+1, 1) = ...
                string( propertyInfo.Name ); %#ok<AGROW>
        end % if
    end % if
end % for

for methodInfo = mc.MethodList.'
    if isChartDefinedPublicMethod( methodInfo, chartClass )
        methodNames(end+1, 1) = string( methodInfo.Name ); %#ok<AGROW>
    end % if
end % for

end % chartDefinedPublicMembers

function tf = isChartDefinedPublicProperty( propertyInfo, chartClass )
%ISCHARTDEFINEDPUBLICPROPERTY True for chart-defined public properties.

tf = strcmp( propertyInfo.DefiningClass.Name, chartClass ) && ...
    isPublicAccess( propertyInfo.GetAccess ) && ...
    ~propertyInfo.Hidden;

end % isChartDefinedPublicProperty

function tf = isChartDefinedPublicMethod( methodInfo, chartClass )
%ISCHARTDEFINEDPUBLICMETHOD True for chart-defined public methods.

tf = strcmp( methodInfo.DefiningClass.Name, chartClass ) && ...
    isPublicAccess( methodInfo.Access ) && ...
    ~methodInfo.Hidden;

end % isChartDefinedPublicMethod

function tf = isPublicAccess( accessValue )
%ISPUBLICACCESS True when a meta access value is public.

tf = isequal( accessValue, "public" ) || isequal( accessValue, 'public' );

end % isPublicAccess

classdef NodeEventData < event.EventData
    %NODEEVENTDATA Data for a node label clicked event.

    properties ( SetAccess = immutable )
        % Node ID.
        NodeID
        % Node label text.
        NodeText
    end % properties ( SetAccess = immutable )

    methods

        function obj = NodeEventData( nodeID, nodeText )
            %NODEEVENTDATA Construct a NodeEventData object, given the node
            %ID and text.

            arguments ( Input )
                nodeID(1, 1) double {mustBeInteger, mustBePositive}
                nodeText(1, 1) string
            end % arguments ( Input )

            obj.NodeID = nodeID;
            obj.NodeText = nodeText;

        end % constructor

    end % methods

end % classdef
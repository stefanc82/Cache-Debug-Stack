ROUTINE DebugStackDefines [Type=INC]
#Include %occIO

#define InitialiseDebugStack	Set tDebugStack = $get(tDebugStack, ##class(MasterLib.Utils.Exception.DebugStack).%New())
#define AddDebugInfo(%Value)	Do tDebugStack.AddInfoToStack($$$CurrentClass, $$$CurrentMethod, %Value)
#define AddDebugStack(%Stack)	Do tDebugStack.AddStackToStack(%Stack)
#define DebugStackToString		tDebugStack.ToString()
#define DebugStackVariableName	tDebugStack

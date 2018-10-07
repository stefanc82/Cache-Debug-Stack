/// Debug Stack Class used for building a stack of information at runtime.<be>
/// The stack can be placed into a stream which can be stored for use later.
Class MasterLib.Utils.Exception.DebugStack Extends %RegisteredObject
{

/// A semi-colon separated list of values. Contains ClassName, MethodName and Debug Information. It can also contain a subset of StackLines Private
Property StackLines As %Library.ListOfDataTypes [ Private ];

/// A semi-colon separated list of values. Contains ClassName, MethodName and Debug Information. It can also contain a subset of StackLines Private
Property StackOutput As %Stream.GlobalCharacter [ Private ];

/// Method to Add info to the DebugStack, Data passed in.
Method AddInfoToStack(pClass As %String, pMethod As %String, pStackInfo As %String)
{
	set tNewElement = pClass_";"_pMethod_";"_pStackInfo
	do ..StackLines.Insert(tNewElement)
}

/// Method to Add info to the DebugStack, Stack passed in.
Method AddStackToStack(pStack As MasterLib.Utils.Exception.DebugStack)
{
	do ..StackLines.Insert(pStack.StackLines)
}

/// Private method called to help indent the DebugStack according to error. Will be added to a stram 
Method StackToStream(pStack As %Library.ListOfDataTypes, pLevel As %Integer) [ Private ]
{
	for i=1:1:pStack.Count()
	{
		set tElement = pStack.GetAt(i)
		if ($classname(tElement) = "%Library.ListOfDataTypes") {
			do ..StackToStream(tElement,pLevel+1)
		} else {
			if (pLevel > 0) {
				do ..StackOutput.Write("|")
				for j=1:1:pLevel { 
					do ..StackOutput.Write("  |")
				}
				do ..StackOutput.Write("- ")
			}
			do ..StackOutput.WriteLine($Translate(tElement,";",$char(9))) 
		}
	}
}

/// Prints out the Debug Stack with indentation. 
Method ToString() As %String
{
	do ..ToGCStream()
	do ..StackOutput.Rewind()
	return ..StackOutput.Read()
}

/// Create a GlobalCharacterStream containing the stack of information. 
Method ToGCStream() As %Stream.GlobalCharacter
{
	set ..StackOutput = ##class(%Stream.GlobalCharacter).%New()
	do ..StackToStream(..StackLines,0)
	return ..StackOutput
}

}

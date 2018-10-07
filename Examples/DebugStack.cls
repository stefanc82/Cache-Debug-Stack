Include DebugStackDefines

/// A simple example to illustrate the use of the debug stack
Class Examples.DebugStack Extends %RegisteredObject
{

ClassMethod TestDebugStack() As %Status
{
	set sc = $$$OK
	$$$InitialiseDebugStack
	try
	{
		set tVal = 5
		$$$AddDebugInfo("Calling Method InnerStackTest with value: " _ tVal)
		
		set sc = ..TestInnterStack(tVal, .tDebStackP)
		$$$AddDebugStack(tDebStackP)
		if ($$$ISERR(sc)) {
			throw
		}
		$$$AddDebugInfo("TestInnerStack completed OK")
		
		// For example purposes the debug stack will be written out
		w $$$DebugStackToString
		
	} catch tEx {
		
		// Optionally log the debugstack stream using a persistent class to enable devops to evaluate system exceptions.
		// Optional on Ensemble: Send an Alert containing the %Id value of the stored exception containing the debugstack
	}
	quit sc
}

ClassMethod TestInnterStack(pVal As %Integer, ByRef pDebStack As MasterLib.Utils.Exception.DebugStack) As %Status
{
	set sc = $$$OK
	$$$InitialiseDebugStack
	try
	{
		$$$AddDebugInfo("pVal argument: " _ pVal)
		
		set tMyVal = pVal + 10
		$$$AddDebugInfo("tMyVal: " _ tMyVal)
		
		$$$AddDebugInfo("Calling TestThirdLevelStack with tMyVal: " _ tMyVal)
		set sc = ..TestThirdLevelStack(tMyVal, .tDebStackP)
		$$$AddDebugStack(tDebStackP)
		if ($$$ISERR(sc)) {
			throw
		}
		$$$AddDebugInfo("TestThirdLevelStack completed OK")
		
	} catch tEx {
		set:(sc=$$$OK) sc = tEx.AsStatus()
		$$$AddDebugInfo("Exception handled sc: " _ $System.Status.GetErrorText(sc))
	}
	set pDebStack = $$$DebugStackVariableName
	quit sc
}

ClassMethod TestThirdLevelStack(pVal As %Integer, ByRef pDebStack As MasterLib.Utils.Exception.DebugStack) As %Status
{
	set sc = $$$OK
	$$$InitialiseDebugStack
	try
	{
		$$$AddDebugInfo("pVal argument: " _ pVal)
		
		set tFinalVal = pVal + 20
		$$$AddDebugInfo("tFinalVal: " _ tFinalVal)
		
	} catch tEx {
		set:(sc=$$$OK) sc = tEx.AsStatus()
		$$$AddDebugInfo("Exception handled sc: " _ $System.Status.GetErrorText(sc))
	}
	set pDebStack = $$$DebugStackVariableName
	quit sc
}

}

function Component()
{
	//default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();
	
	if( (systemInfo.productType === "win") ||
		(systemInfo.productType === "windows"))
	{
        component.addOperation("CreateShortcut", "@TargetDir@/BunnyAndQloud.exe", "@DesktopDir@/BunnyAndQloud.lnk");
		component.addOperation("CreateShortcut", "@TargetDir@/BunnyAndQloud.exe", "@StartMenuDir@/BunnyAndQloud.lnk");
    }
}

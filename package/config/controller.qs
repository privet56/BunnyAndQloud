function Controller()
{
	//default constructor
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
	if(systemInfo.currentCpuArchitecture.indexOf("64") < 1)
	{
		QMessageBox["critical"]("Error", "Error", "You cannot install this 64bit App on a win32 system!", QMessageBox.Ok);
		gui.rejectWithoutPrompt();
	}
}

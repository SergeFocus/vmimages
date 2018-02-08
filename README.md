## Образа Windows для сборки 1С

содержит образа для сборки 1С

### Windows 10

* базовый - Windows 10 c установленным chocolatey

## Packer files for Windows 2016 / VMWare Fusion

A packer files for a minimal Windows 2016 virtual machine with just enough to run docker accessible
from the host system.

### Packages Included

 * Chocolatey
 * OpenSSH
 * VMWare Guest Tools

### References/Sources

* https://github.com/taliesins/packer-baseboxes/blob/master/hyperv-windows-2016-serverstandard-amd64.json
* https://github.com/StefanScherer/packer-windows
* https://github.com/dylanmei/packer-windows-templates
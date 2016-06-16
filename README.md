foldersigner-powershell
================================

Digitally sign or timestamp PDF's in a specific folder using Windows Powershell.

A Powershell script is used to monitor a specific inbox folder for any new PDF files.
If a new PDF is found, it will be signed via Swisscom AIS Signing Service. The signed PDF will be moved to a specific outbox folder.

## Configuration

Edit the `foldersigner.ps1` accordingly.
Edit the `signpdf.properties` accordingly.

## Run

To start, run the Powershell Terminal and run the `foldersigner.ps1`
```
PS> cd c:\foldersigner
PS> .\folderSigner.ps1
```

The script will then create a new Event with the identifier `FolderSigner`.
By default, a log file `folderSigner.log`is created in the outbox folder.

## Powershell Commands

List Events:
```
PS> Get-EventSubscriber
```

Unregister Events (e.g. required before you restart the script):
```
PS> Unregister-Event -SourceIdentifier FolderSigner –Verbose
```

## Example:
```
06/16/2016 14:42:42 - Processing 'sample.pdf' from inbox...
06/16/2016 14:42:42 - 'sample.pdf' successfully signed.
```

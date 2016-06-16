  $inbox = 'c:\foldersigner\inbox'
  $filter = '*.pdf'      
  
  $fsw = New-Object IO.FileSystemWatcher $inbox, $filter -Property @{
   IncludeSubdirectories = $false             
   NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
  }
  
  $onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FolderSigner -Action { 
   $result = ""
   $logfile = "c:\foldersigner\outbox\folderSigner.log"
   $classpath = '.;c:\foldersigner\;c:\foldersigner\lib\*'
   $outbox = 'c:\foldersigner\outbox'
   $class = 'com.swisscom.ais.itext.SignPDF' 
   $path = $Event.SourceEventArgs.FullPath
   $name = $Event.SourceEventArgs.Name
   $timeStamp = $Event.TimeGenerated
   
   Add-content $logfile -value "$timeStamp - Processing '$name' from inbox..."
   
   $result = java -DproxySet="true" -DproxyHost="clientproxy.corproot.net" -DproxyPort="8079" -cp "$classpath" "$class" -v -config="c:\foldersigner\signpdf.properties" -type=sign -infile="$path" -outfile="$outbox\$name" -reason="Signed by Muster Hans" -location="Zuerich, Schweiz" 2>&1
   
   Add-content $logfile -value "$result"
   
   if ("$result" -like '*Success*') {
    Remove-Item -path "$path" -Force
    Add-content $logfile -value "$timeStamp - '$name' successfully signed."
    }
   
   else {
    Add-content $logfile -value "$timeStamp - '$name' signing failed and was not removed from inbox. Reason: '$result'"
    }
   
   }
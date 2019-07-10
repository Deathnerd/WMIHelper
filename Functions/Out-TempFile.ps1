Function Out-TempFile {
    <#
      .Role
       Helper
      .Component
       HSGWMIModuleV6
    #>
    Begin {
        $tmpfile = [io.path]::GetTempFileName()
    }
    Process { $_ >> $tmpFile }
    End {
        notepad $tmpfile | out-null
        Remove-Item $tmpFile
    }
}

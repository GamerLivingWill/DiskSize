function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $DiskNumber,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter
    )


        $getTargetResourceResult = @{
                                      DiskNumber = $DiskNumber;
                                      DriveLetter = $DriveLetter;
                                      Ensure = $ensureResult;
                                    }
  
        $getTargetResourceResult

}#GetTargetResource


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $DiskNumber,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

   
    Try {
    
        New-Partition -DiskNumber $DiskNumber -UseMaximumSize -DriveLetter $DriveLetter | Format-Volume -FileSystem NTFS -Confirm:$false
    
    }
    Catch {
    
        Write-Error -ErrorRecord $PSItem
        Return
    
    }

}#EndSetTargetResource


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $DiskNumber,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    
    Try {
    
        (Get-Partition -DiskNumber $DiskNumber | Where-Object ({$PSItem.DriveLetter -eq $DriveLetter})).DriveLetter -eq $DriveLetter
    
    }
    Catch {
    
        Write-Error -ErrorRecord $PSItem
        Return
    
    }


}#EndTestTargetResource


Export-ModuleMember -Function *-TargetResource


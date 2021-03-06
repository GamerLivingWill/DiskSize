function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.UInt64]
        $DiskSize,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter
    )

	
        $getTargetResourceResult = @{
                                      DiskSize = $DiskSize;
                                      DriveLetter = $DriveLetter;
                                      Ensure = $ensureResult;
                                    }
  
        $getTargetResourceResult
	


}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.UInt64]
        $DiskSize,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    Try {
    
        Resize-Partition -DriveLetter $DriveLetter -Size $DiskSize
    
    }
    Catch {
    
        Write-Error -ErrorRecord $PSItem
        Return
    
    }


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.UInt64]
        $DiskSize,

        [parameter(Mandatory = $true)]
        [System.String]
        $DriveLetter,

        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure
    )

    
    Try {
    
        ((Get-Partition -DriveLetter $DriveLetter).Size -eq $DiskSize)
    
    }
    Catch {
    
        Write-Error -ErrorRecord $PSItem
        Return
    
    }
    
}


Export-ModuleMember -Function *-TargetResource


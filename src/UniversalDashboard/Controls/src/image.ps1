function New-UDImage {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [String]$Url,
        [Parameter()]
        [String]$Path,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [Hashtable]$Attributes = @{}
    )

    if (-not [String]::IsNullOrEmpty($Path)) {
        if (-not (Test-Path $Path)) {
            throw "$Path does not exist."
        }

        $mimeType = 'data:image/png;base64, '
        if ($Path.EndsWith('jpg') -or $Path.EndsWith('jpeg')) {
            $mimeType = 'data:image/jpg;base64, '
        }

        $base64String = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($Path))

        $Url = "$mimeType $base64String"
    }

    if ($PSBoundParameters.ContainsKey('Url')) {
        $Attributes.'src' = $Url
    }
    if ($PSBoundParameters.ContainsKey('Height')) {
        $Attributes.'height' = $Height
    }
    if ($PSBoundParameters.ContainsKey('Width')) {
        $Attributes.'width' = $Width
    }

    New-UDElement -Tag 'img' -Attributes $Attributes
}
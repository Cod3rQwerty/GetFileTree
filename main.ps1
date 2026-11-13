function FileTree {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string] $dir = (Get-Location),
        [int] $indent = 4
    )

    function Write-FileNames {
        param (
            [string] $targetDir,
            [int] $currentIndent
        )
        $files = Get-ChildItem -Path $targetDir -File -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            Write-Output ((" " * $currentIndent) + $file.Name)
        }
    }

    function Get-NextLevel {
        param (
            [string] $targetDir,
            [int] $current_indent,
            [int] $indent_to_add
        )
        $curr_dir_name = Split-Path -Path $targetDir -Leaf
        Write-Output (((" " * $current_indent) + $curr_dir_name) + "/") 
        Write-FileNames $targetDir ($current_indent + $indent_to_add)

        $subdirs = Get-ChildItem -Path $targetDir -Directory -ErrorAction SilentlyContinue
        foreach ($subdir in $subdirs) {
            Get-NextLevel $subdir.FullName ($current_indent + $indent_to_add) $indent_to_add
        }
    }

    Get-NextLevel $dir 0 $indent
}
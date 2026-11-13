# GetFileTree
A simple CLI tool to get a formatted file tree of a provided directory, with options for directory exclusion and indentation

## Installation
```
irm https://raw.githubusercontent.com/Cod3rQwerty/GetFileTree/main/main.ps1 | iex
```
## Usage
Once installed, simply run
```powershell
FileTree
```
 in the desired directory, or provide the directory:
```powershell
 FileTree <directory>
```

### Indentation Levels
To run with a different indentation level, run:
```powershell
FileTree -indent <indent number>
```

### Excluding Directories
Sometimes, for example with .git or other such directories, you may want to exclude them from the file tree.
To do this, simply run:
```powershell
FileTree -e "directory_name"
```
For example, to get a file tree of a React codebase, you could run:
```powershell
FileTree -e "node_modules", ".git"
```
This excludes both the `node_modules` directory and `.git` directory.

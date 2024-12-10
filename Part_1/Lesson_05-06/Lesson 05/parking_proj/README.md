# PMD Pre-Commit Hook Configuration

This repository contains the configuration files and setup instructions to automate static code analysis using PMD with Git pre-commit hooks.

## Requirements

1. **PMD**: Ensure you have PMD version 6.55 installed. You can download it from [PMD Downloads](https://pmd.github.io/).
2. **Git**: A Git repository where the pre-commit hook will be added.

## Repository Structure

```
├── config/
│   └── ruleset.xml         # PMD ruleset configuration
├── hooks/
│   └── pre-commit          # Pre-commit hook script
```

## Steps to Configure

### 1. Clone the Repository
Clone your repository locally if you haven’t already:`

`git clone`

### 2. Place the Files
Ensure the following files are in their respective locations:
- `config/ruleset.xml`: Contains the PMD rules for static code analysis.
- `.git/hooks/pre-commit`: Contains the script to automate PMD execution before a commit.

### 3. Make the Pre-Commit Script Executable
Run the following command to make the pre-commit script executable:

`chmod +x .git/hooks/pre-commit`

### 5. Test the Setup
Make a Git commit to verify that PMD runs automatically. If issues are found in the code, the commit will be aborted, and PMD will display the errors in the terminal.

## Example Command for Manual PMD Execution
To test PMD manually, use the following command:

`./pmd-bin-6.55.0/`

### 6. Verify PMD Installation
Ensure that PMD is installed and accessible via the following directory:

```
./pmd-bin-6.55.0/bin/run.sh pmd 
–dir /path/to/your/project 
–rulesets /path/to/your/project/config/ruleset.xml 
–format text
```

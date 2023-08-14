## Branches

**'dev'**
 branch is the last actual version for developers. So developers work in these branch, merge it and create new branches from it for tasks.

**'master'**
 is the last version of released app.

For all tasks (*even small ones*) you need to create a new branch from 'dev' and work on own one. Name your branches after name of task in **kebab-case**. And commits after this rule:
`${branch-name}: ${commit-name}`. 
For example:
`Product-screen: added counter for product screen`.

## Code Guidance

- Material 3 support
- All UI components should be divided into separate public widgets
- You should add comments to all methods and variables that you add
- Must support Flutter Web
- All public widgets must be named with Prefix “ECom”, like (EComCustomWidget)
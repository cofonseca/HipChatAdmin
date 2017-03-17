# PSHipChat

PSHipChat is a simple PowerShell module designed to work with Atlassian HipChat. The module started as a simple script to add a new user whenever we hired a new employee, and slowly grew into what it is today. PSHipChat uses HipChat's API V2 to achieve its functionality.

## Installing PSHipChat
To install and use PSHipChat, simply move the PSHipChat folder into your Modules folder. If you're not sure where your Modules folder is, open up PowerShell and type $env:PSModulePath. You can use any of the folders there, but we recommend \Documents\WindowsPowerShell\Modules.

## Obtaining an API Key

To use PSHipChat, you will need to obtain an API key from HipChat. As an admin, you can do this right from HipChat's website by logging in as yourself, and navigating to Account Settings > API Access. Your API key will need to have the following scopes:
- Administer Group
- Manage Rooms
- Send Notification

## Using PSHipChat

PSHipChat contains several helpful functions:

#### New-HipchatUser
Creates a new user in HipChat.
```
New-HipchatUser -FirstName 'John' -LastName 'Smith'
```

#### Remove-HipchatUser
Deletes an existing user from HipChat.
```
Remove-HipchatUser -MentionName 'JohnSmith'
```

#### New-HipchatRoom
Creates a new room in HipChat.
```
New-HipchatRoom -Name 'Marketing' -Private
```

#### Remove-HipchatRoom
Deletes an existing room from HipChat, as long as there are no users in the room.
```
Remove-HipchatRoom -Name 'Marketing'
```

#### Add-HipchatUserToRoom
Invites an existing HipChat user to join a room.
```
Add-HipchatUserToRoom -MentionName 'JohnSmith','SallyWalker' -Room 'Finance'
```

#### Remove-HipchatUserFromRoom
Kicks an existing HipChat user out of a room.
```
Remove-HipchatUserFromRoom -MentionName 'SallyWalker' -Room 'Finance'
```

#### Send-HipchatMessage
Posts a custom message in any existing HipChat room.
```
Send-HipchatMessage -Room 'Development' -Message 'Build Failed!' -BackgroundColor 'Red'
```

## Contributing to PSHipChat
I am always open to feedback, new ideas, and bug fixes. If you would like to help improve this project, please feel free to submit an issue or a pull request.
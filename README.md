# HipChatAdmin

HipChatAdmin is a simple PowerShell module designed to work with Atlassian HipChat. The module started as a simple script designed to create employee accounts during onboarding, and has slowly grown into what it is today. HipChatAdmin uses HipChat's API V2 to achieve its functionality, and contains a bunch of useful functions out of the box that allow you to automate user creation and removal, posting to rooms, and more. This would be a great addition to your employee onboarding scripts!

This module was previous titled PSHipChat, but due to a naming conflict on PowerShell Gallery, the name has been changed.

## Installing HipChatAdmin
There are two ways to install HipChatAdmin:

To install HipChatAdmin automatically from the PowerShell Gallery, simply open up a PowerShell prompt and type "Install-Module -Name HipChatAdmin".

To install HipChatAdmin manually, or if you are using an earlier version of PowerShell that doesn't support Install-Module, simply download the module from GitHub, and copy the HipChatAdmin folder into your Modules folder. If you're not sure where your Modules folder is, open up a PowerShell prompt and type $env:PSModulePath. You can use any of the folders there, but we recommend \Documents\WindowsPowerShell\Modules.

## Obtaining an API Key

To use HipChatAdmin, you will need to obtain an API key from HipChat. As an admin, you can do this right from HipChat's website by logging in as yourself, and navigating to Account Settings > API Access. Your API key will need to have the following scopes:
- Administer Group
- Manage Rooms
- Send Notification

## Using HipChatAdmin

HipChatAdmin contains several helpful functions:

#### New-HipchatUser
Creates a new user in HipChat.
```
New-HipchatUser -FirstName 'John' -LastName 'Smith' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Remove-HipchatUser
Deletes an existing user from HipChat.
```
Remove-HipchatUser -MentionName 'JohnSmith' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Get-HipchatUser
Returns a list of all existing HipChat users' names and mention names.
```
Get-HipchatUser -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### New-HipchatRoom
Creates a new room in HipChat.
```
New-HipchatRoom -Name 'Marketing' -Private -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Remove-HipchatRoom
Deletes an existing room from HipChat, and kicks all users from the room.
```
Remove-HipchatRoom -Name 'Marketing' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Add-HipchatUserToRoom
Invites an existing HipChat user to join a room.
```
Add-HipchatUserToRoom -MentionName 'JohnSmith','SallyWalker' -Room 'Finance' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Remove-HipchatUserFromRoom
Kicks an existing HipChat user out of a room.
```
Remove-HipchatUserFromRoom -MentionName 'SallyWalker' -Room 'Finance' -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

#### Send-HipchatMessage
Posts a custom message in any existing HipChat room.
```
Send-HipchatMessage 'Build Failed!' -Room 'Development' -BackgroundColor 'red' -Notify $false -ApiToken 'REXsCauSe553gsoIJg1Gj4zwNsSAwS'
```

## Contributing to HipChatAdmin
I am always open to feedback, new ideas, and bug fixes. If you would like to help improve this project, please feel free to submit an issue or a pull request.
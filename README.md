# Teams

----
**This project is now retired as Microsoft have retired the Linux Teams client.**  https://office365itpros.com/2022/09/19/teams-pwa-linux-client/

----

## Description

Installs Microsoft's Teams client for Linux onto a Debian 9, Debian 10, or Ubuntu 18.04 system.

### Use cases

You are managing Debian-like workstations or X2go-fronted Debian-like timeshare servers in an institution that has adopted MS Teams.

## Setup

### What Teams affects

- Adds the Teams Apt repository and Microsoft's signing key.
- Download and installs the Teams client using Apt.

### Setup Requirements

The Teams module is designed to work with Puppet agent versions 5 and 6.  It is therefore depends on specific versions of puppetlabs/apt and puppetlabs/stdlib that I happen to be using to work with Puppet 5 and 6.  These version specifications may be more restrictive than they need to be.  If you successfully modify the module to work with a wider range of versions of apt or stdlib then please submit a pull request with your changes, including relevant unit tests.

### Beginning with Teams

Add the Teams module to your control repo's Puppetfile and `include teams` in any manifest.  You need to write `include apt` or `class { 'apt': # parameter list here }` first: I deliberately didn't do that in the module because Puppet only lets you invoke a class once and you've probably already invoked `apt` somewhere else in your manifest.

### Parameters etc

There are no parameters at this time.

## Note about this git repo

If you were looking through the first few commits and wondering why the manifest references a non-existent file _files/teams_1.2.00.32451_amd64.deb_, I removed it completely using `git filter-branch` to keep the repo size down and also avoid any legal trouble about distributing proprietary software within this module's repo.  Versions prior to 1.0.0 used `dpkg` to install that deb file, which was included in the module repo for convenience.

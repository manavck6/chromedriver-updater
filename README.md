# ChromeDriver Updater

This repository contains a batch script to automatically update ChromeDriver to the latest version. The script fetches the latest version of ChromeDriver from the official Google Chrome Labs API, downloads it, and replaces the existing ChromeDriver executable.

## Features

- Automatically fetches the latest stable version of ChromeDriver.
- Downloads the ChromeDriver zip file.
- Extracts and replaces the existing ChromeDriver executable.
- Cleans up temporary files after the update.

## Prerequisites

- Windows operating system
- PowerShell
- curl (included in Windows 10 and later)

## Usage

1. Clone the repository:
   ```sh
   git clone https://github.com/manavck6/chromedriver-updater.git

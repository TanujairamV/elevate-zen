Yes. For Windows, use **WinGet** commands instead of download links.

# Elevate Zen — Developer Installation

## 🐧 Linux

### 1. Install Git

Arch Linux:

```bash
sudo pacman -S git
```

### 2. Install Flutter

```bash
yay pacman -S flutter-bin
```

### 3. Install VS Code

```bash
sudo pacman -S code
```

Then install the **Flutter** extension from VS Code.

### 4. Clone the project

```bash
git clone https://github.com/TanujairamV/elevate-zen.git
cd elevate-zen
```

### 5. Install dependencies

```bash
flutter pub get
```

### 6. Check the environment

```bash
flutter doctor
```

### 7. Run the app

```bash
flutter run -d linux
```

---

# 🪟 Windows

### 1. Install Git

Open **PowerShell**:

```powershell
winget install --id Git.Git -e
```

### 2. Install VS Code

```powershell
winget install --id Microsoft.VisualStudioCode -e
```

### 3. Install Flutter

```powershell
winget install --id Google.Flutter -e
```

Restart PowerShell after installation.

Verify:

```powershell
flutter --version
```

### 4. Install Flutter/Dart extensions

Open VS Code:

```powershell
code .
```

Install:

* **Flutter**
* **Dart**

### 5. Clone the project

```powershell
git clone https://github.com/TanujairamV/elevate-zen.git
cd elevate-zen
```

### 6. Install dependencies

```powershell
flutter pub get
```

### 7. Check the environment

```powershell
flutter doctor
```

For **Windows desktop**, Flutter requires Visual Studio with the **Desktop development with C++** workload. If `flutter doctor` reports that Visual Studio is missing, install it with:

```powershell
winget install --id Microsoft.VisualStudio.2022.Community -e
```

Then install the **Desktop development with C++** workload through Visual Studio Installer.

### 8. Run Elevate Zen

```powershell
flutter run -d windows
```

## Quick Start

### Linux

```bash
sudo pacman -S git flutter code
git clone https://github.com/TanujairamV/elevate-zen.git
cd elevate-zen
flutter pub get
flutter run -d linux
```

### Windows

```powershell
winget install --id Git.Git -e
winget install --id Microsoft.VisualStudioCode -e
winget install --id Google.Flutter -e
git clone https://github.com/TanujairamV/elevate-zen.git
cd elevate-zen
flutter pub get
flutter run -d windows
```

**Note:** The Windows developer should run `flutter doctor` after installation and resolve any missing Windows desktop dependencies before testing.

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

## Quick Start

### Linux

```bash
sudo pacman -S git flutter code
git clone https://github.com/TanujairamV/elevate-zen.git
cd elevate-zen
flutter pub get
flutter run -d linux
```
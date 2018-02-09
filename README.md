## RKLayoutLibrary
This is an "Swift Autolayout Tool" that is easy to read and easy to coding for iOS.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Requirements

- iOS 8.0+ 
- Xcode 8.x
- Xcode 9.x
- Swift 3.x 
- Swift 4.x

## Installation

### CocoaPods

To integrate RKLayoutLibrary into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '[Your Target Name]' do
    pod 'RKLayoutLibrary', '~> 0.1.2'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

You can integrate RKLayoutLibrary into your project manually.

---

## Usage

### Quick Start

```swift
class MyViewController: UIViewController {

    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(redView) { make in
            make.kLayoutCenter(equalTo: view)
            make.kLayout(.height, equalTo: view).multi(0.5)
            make.kLayoutHorizontalRatio(0.5)
        }
    }

}
```


### General

```swift 
  view.addSubview(redView)
  
  redView.makeLayout { make in
      make.kLayoutCenter(equalTo: view)
      make.kLayout(.height, equalTo: view).multi(0.5)
      make.kLayoutHorizontalRatio(0.5)
  }

```

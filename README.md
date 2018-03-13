Swift Base Project
============================================

## Introduction

The goal of this project is to work as a template for iOS aplications, providing a base architecture, core frameworks and helpers to jumpstart development.

## Base tooling

- `R.Swift` for xcode asset management.
- `SwiftLint` for style checking.
- `RxSwift` for data flow management.
- `Alamofire` + `TBD` for networking.
- `RealmSwift` + `RxRealm` for database management.
- `Whisper` for in app notification-style messages.

## Usage

// TBD

## Configuring Development and Production Flags

[Check this article](https://kitefaster.com/2016/01/23/how-to-specify-debug-and-release-flags-in-xcode-with-swift/)

TL;DR:
1. Open your Project Build Settings and search for “Swift
2. Compiler – Custom Flags” … “Other Swift Flags”.
3. Add “-DDEBUG” to the Debug section
Add “-DRELEASE” to the Release section

## Architecture

We are going to use MVVM + R, with some caveats:

- The model won't store business logic.
- The viewModel will access the models vía a `Controller`, this controller will be in charge of data management, both on the local database and the network.
- The router will be in charge of building the view, the viewModel and wiring them up.

<img src="./Architecture.png"/>

Sample

```swift
// The router is in charge of instancing the login view and it's viewModel
class AppRouter {

  var rootViewController: UIViewController?
  var window: UIWindow?

  func setupInitialViewController() -> UIViewController {
    guard let initialVC = R.storyboard.main.instantiateInitialViewController() else { return UIViewController() }
    initialVC.viewModel = LoginViewModel(router: self)
    let navigationController = UINavigationController(rootViewController: initialVC)
    rootViewController = navigationController
    return navigationController
  }

  func goToDashboard() {
    guard let dashboard = R.storyboard.dashboard.instantiateInitialViewController() else { return }
    let navigationController = UINavigationController(rootViewController: dashboard)
    rootViewController = navigationController
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.window?.rootViewController = navigationController
    }
  }
}

class LoginViewModel {

  private var disposeBag = DisposeBag()
  private var router: AppRouter
  var userName = Variable<String?>(nil)
  var password = Variable<String?>(nil)
  var canSubmit = Variable<Bool>(false)

  init(router: AppRouter) {
    self.router = router
    Observable.combineLatest(
      userName.asObservable(),
      password.asObservable()
    ).subscribe(
      onNext: { [unowned self] (user, pass) in
        guard let user = user, let pass = pass else { return }
        self.canSubmit.value = !user.isEmpty && !pass.isEmpty
      }
    ).disposed(by: disposeBag)
  }

  func login() {
    UserController.login(userName.value, password.value).subscribe(
      onNext: { [weak self] result in
        self?.router.goToDashboard()
      }
    ).disposed(by: disposeBag)
  }
}

class LoginViewController: UIViewController {

  @IBOutlet weak var userNameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  var viewModel: LoginViewModel!
  private var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  func setup() {
    userNameField.rx
      .text
      .bind(to: viewModel.userName)
      .disposed(by: disposeBag)
    passwordField.rx
      .text
      .bind(to: viewModel.password)
      .disposed(by: disposeBag)
    viewModel.canSubmit.asObservable().subscribe(
      onNext: { [unowned self] canSubmit in
        self.loginBtn.isEnabled = canSubmit
      }
    ).disposed(by: disposeBag)
    loginBtn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
  }

  @objc func loginTapped() {
    viewModel.login()
  }

}

// In AppDelegate `didFinishLaunchingWithOptions`add this to start your app

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let rootVC = appRouter.setupInitialViewController()
    window?.rootViewController = rootVC
    window?.makeKeyAndVisible()
    appRouter.window = window
    return true
}
```



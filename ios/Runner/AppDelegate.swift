import UIKit
import Flutter

//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//}

import UIKit
import Flutter
import FacebookCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}

    override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
    ApplicationDelegate.shared.application(
        app,
        open: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
}
}



// 페이스북 SDK 설치를 위해 아래 코드로 대체
//import UIKit
//import Flutter
//import FacebookCore
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//) -> Bool {
//    ApplicationDelegate.shared.application(
//        application,
//        didFinishLaunchingWithOptions: launchOptions
//    )
//
//    return true
//}
//
//func application(
//    _ app: UIApplication,
//    open url: URL,
//    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//) -> Bool {
//    ApplicationDelegate.shared.application(
//        app,
//        open: url,
//        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//    )
//}
//}

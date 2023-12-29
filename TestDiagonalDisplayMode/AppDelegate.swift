//
//  AppDelegate.swift
//  TestDiagonalDisplayMode
//
//  Created by VAndrJ on 28.12.2023.
//

import VATextureKit

// Adjusted for iPhone 11 only 💩
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private let rotationInformationService = RotationInformationService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = VAWindow(standardLightTheme: .vaLight, standardDarkTheme: .vaDark)
        window.rootViewController = ASDKViewController(node: ControllerNode(
            rotationObs: rotationInformationService.rotationObs
                .distinctUntilChanged({ abs($0 - $1) < EnvironmentConfiguration.rotationAngleDiscretization })
        ))
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        rotationInformationService.start()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        rotationInformationService.stop()
    }
}

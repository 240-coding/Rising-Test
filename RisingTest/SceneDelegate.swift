//
//  SceneDelegate.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/18.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)

        if (AuthApi.hasToken() && UserDefaults.standard.bool(forKey: "isLogin")) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
                    guard let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else {
                        return
                    }
                    self.window?.rootViewController = rootViewController
                    self.window?.makeKeyAndVisible()
                }
            }
        }
        else {
            //로그인 필요
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            guard let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return
            }
            self.window?.rootViewController = rootViewController
            self.window?.makeKeyAndVisible()
        }
        
//        if UserDefaults.standard.bool(forKey: "isLogin") {
//            let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
//            guard let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else {
//                return
//            }
//            self.window?.rootViewController = rootViewController
//            self.window?.makeKeyAndVisible()
//        } else {
//            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
//            guard let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
//                return
//            }
//            self.window?.rootViewController = rootViewController
//            self.window?.makeKeyAndVisible()
//        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


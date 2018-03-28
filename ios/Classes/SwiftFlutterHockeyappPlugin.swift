import Flutter
import UIKit
import HockeySDK_Source
    
public class SwiftFlutterHockeyappPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_hockeyapp", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHockeyappPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    private var _token: String = ""
    private var _isInitialized = false

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    let dic = call.arguments as? [String: Any]
    switch (method) {
    case "start":
        start()
        result(true)
        break
    case "checkForUpdates":
        checkForUpdates()
        result(true)
        break
    case "configure":
        configure(token: dic?["token"] as! String)
        result(true)
        break
    case "showFeedback":
        showFeedback()
        result(true)
        break
    case "trackEvent":
        trackEvent(eventName: dic?["eventName"] as! String)
        result(true)
        break
    default:
        result("iOS " + UIDevice.current.systemVersion)
        break
    }
  }
    //4d65be5d8d6f4a3fbbf920e5cd77bd43
    
    private func trackEvent(eventName: String) {
        if (!_isInitialized) {
            NSLog("HockeyApp not initialized\n")
            return
        }
        BITHockeyManager.shared().metricsManager.trackEvent(withName: eventName)
    }
    
    private func showFeedback() {
        if (!_isInitialized) {
            NSLog("HockeyApp not initialized\n")
            return
        }
        BITHockeyManager.shared().feedbackManager.showFeedbackListView()
    }
    
    private func checkForUpdates() {
        if (!_isInitialized) {
            NSLog("HockeyApp not initialized\n")
            return
        }
    BITHockeyManager.shared().updateManager.checkForUpdate()
    }
    
    private func configure(token: String) {
        NSLog("Configuring HockeyApp with token: " + token)
        _token = token
        _isInitialized = true
    }
    
    private func start() {
        if (!_isInitialized) {
            NSLog("HockeyApp not initialized\n")
            return
        }
        BITHockeyManager.shared().configure(withIdentifier: _token)
        BITHockeyManager.shared().crashManager.crashManagerStatus = BITCrashManagerStatus.autoSend
        BITHockeyManager.shared().start()
    }
}

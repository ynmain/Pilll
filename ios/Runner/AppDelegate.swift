import UIKit
import ObjectiveC
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let channelName = "method.channel.MizukiOhashi.Pilll"
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.migrateFrom_1_3_2()
        }
        configureNotificationActionableButtons()
        UNUserNotificationCenter.current().swizzle()
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["repeat_notification_for_taken_pill", "remind_notification_for_taken_pill"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["repeat_notification_for_taken_pill", "remind_notification_for_taken_pill"])
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

// MARK: - Internal
extension AppDelegate {
    func call(method: String, arguments: [String: Any]?) {
        let viewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "method.channel.MizukiOhashi.Pilll",
            binaryMessenger: viewController.binaryMessenger
        )
        channel.invokeMethod(method, arguments: arguments)
    }
}

// MARK: - Avoid bug for flutter app badger
// ref: https://github.com/g123k/flutter_app_badger/pull/52
extension UNUserNotificationCenter {
    func swizzle() {
        guard let fromMethod = class_getInstanceMethod(type(of: self), #selector(UNUserNotificationCenter.setNotificationCategories(_:))) else {
            fatalError()
        }
        guard let toMethod = class_getInstanceMethod(type(of: self), #selector(UNUserNotificationCenter.setNotificationCategories_methodSwizzle(_:))) else {
            fatalError()
        }

        method_exchangeImplementations(fromMethod, toMethod)
    }

    @objc func setNotificationCategories_methodSwizzle(_ categories: Set<UNNotificationCategory>) {
        if categories.isEmpty {
            return
        }
        setNotificationCategories_methodSwizzle(categories)
    }

}

// MARK: - Notification
extension AppDelegate {
    func migrateFrom_1_3_2() {
        if let salvagedValue = UserDefaults.standard.string(forKey: "startSavedDate"), let lastTakenDate = UserDefaults.standard.string(forKey: "savedDate") {
            call(method: "salvagedOldStartTakenDate", arguments: ["salvagedOldStartTakenDate": salvagedValue, "salvagedOldLastTakenDate": lastTakenDate])
        }
    }

    func configureNotificationActionableButtons() {
        let recordAction = UNNotificationAction(identifier: "RECORD_PILL",
                                                title: "飲んだ")
        let category =
            UNNotificationCategory(identifier: Category.pillReminder.rawValue,
                                   actions: [recordAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }


    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        func end() {
            var isCompleted: Bool = false
            let completionHandlerWrapper = {
                isCompleted = true
                completionHandler()
            }

            UIApplication.shared.applicationIconBadgeNumber = 0

            super.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandlerWrapper)

            if !isCompleted {
                completionHandlerWrapper()
            }
        }

        switch extractCategory(userInfo: response.notification.request.content.userInfo) {
        case nil:
            return
        case .pillReminder:
            switch response.actionIdentifier {
            case "RECORD_PILL":
                call(method: "recordPill", arguments: nil)
                end()
            default:
                end()
            }
        }
    }

    enum Category: String {
        case pillReminder = "PILL_REMINDER"
    }

    func extractCategory(userInfo: [AnyHashable: Any]) -> Category? {
        guard let apns = userInfo["aps"] as? [String: Any], let category = apns["category"] as? String else {
            return nil
        }
        return Category(rawValue: category)
    }
}

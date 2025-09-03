#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
#import <objc/runtime.h>

@interface SBApplicationController : NSObject
+ (instancetype)sharedInstance;
- (id)applicationWithBundleIdentifier:(NSString *)bundleIdentifier;
@end

@interface SBApplication : NSObject
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *displayName;
@end

@interface SBUIController : NSObject
+ (instancetype)sharedInstance;
- (void)presentAlertController:(UIAlertController *)alertController animated:(BOOL)animated completion:(void(^)(void))completion;
@end

@interface SBSApplicationShortcutService : NSObject
- (void)launchApplicationWithBundleIdentifier:(NSString *)bundleIdentifier;
@end

// Глобальная переменная для отслеживания состояния
static BOOL isShowingAlert = NO;

// Вспомогательная функция для показа алерта
static void showBlockedAppAlert(NSString *bundleIdentifier) {
    if (isShowingAlert) return;
    isShowingAlert = YES;
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.greatlove.gudestroyer"];
    NSString *alertTitle = [defaults stringForKey:@"alertTitle"] ?: @"Приложение заблокировано";
    NSString *alertMessage = [defaults stringForKey:@"alertMessage"] ?: @"Это приложение заблокировано GuDestroyer";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" 
                                                       style:UIAlertActionStyleDefault 
                                                     handler:^(UIAlertAction *action) {
        isShowingAlert = NO;
    }];
    [alert addAction:okAction];
    
    // Получаем главное окно и показываем алерт
    UIWindow *keyWindow = nil;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    
    if (keyWindow && keyWindow.rootViewController) {
        [keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        isShowingAlert = NO;
    }
}

%hook SBSApplicationShortcutService

- (void)launchApplicationWithBundleIdentifier:(NSString *)bundleIdentifier {
    // Проверяем настройки
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.greatlove.gudestroyer"];
    BOOL isEnabled = [defaults boolForKey:@"enabled"];
    
    if (isEnabled && !isShowingAlert) {
        NSArray *blockedApps = [defaults arrayForKey:@"blockedApps"];
        if (blockedApps && [blockedApps containsObject:bundleIdentifier]) {
            // Показываем алерт и блокируем запуск
            dispatch_async(dispatch_get_main_queue(), ^{
                showBlockedAppAlert(bundleIdentifier);
            });
            return; // Блокируем запуск
        }
    }
    
    %orig;
}

%end

%hook SBApplicationController

- (id)applicationWithBundleIdentifier:(NSString *)bundleIdentifier {
    // Дополнительная проверка через SBApplicationController
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.greatlove.gudestroyer"];
    BOOL isEnabled = [defaults boolForKey:@"enabled"];
    
    if (isEnabled && !isShowingAlert) {
        NSArray *blockedApps = [defaults arrayForKey:@"blockedApps"];
        if (blockedApps && [blockedApps containsObject:bundleIdentifier]) {
            // Логируем попытку запуска заблокированного приложения
            NSLog(@"[GuDestroyer] Блокировка приложения: %@", bundleIdentifier);
            return nil; // Возвращаем nil для блокировки
        }
    }
    
    return %orig;
}

%end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    // Инициализируем настройки по умолчанию
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.greatlove.gudestroyer"];
    if (![defaults objectForKey:@"enabled"]) {
        [defaults setBool:NO forKey:@"enabled"];
        [defaults setObject:@[] forKey:@"blockedApps"];
        [defaults setObject:@"Приложение заблокировано" forKey:@"alertTitle"];
        [defaults setObject:@"Это приложение заблокировано GuDestroyer" forKey:@"alertMessage"];
        [defaults synchronize];
    }
}

%end

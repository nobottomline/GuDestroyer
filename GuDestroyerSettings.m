#import <UIKit/UIKit.h>
#import <spawn.h>

@interface GuDestroyerSettings : UITableViewController
@property (nonatomic, strong) UISwitch *enabledSwitch;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *messageField;
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation GuDestroyerSettings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GuDestroyer";
    self.defaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.greatlove.gudestroyer"];
    
    // Инициализируем настройки по умолчанию
    if (![self.defaults objectForKey:@"enabled"]) {
        [self.defaults setBool:NO forKey:@"enabled"];
        [self.defaults setObject:@[] forKey:@"blockedApps"];
        [self.defaults setObject:@"Приложение заблокировано" forKey:@"alertTitle"];
        [self.defaults setObject:@"Это приложение заблокировано GuDestroyer" forKey:@"alertMessage"];
        [self.defaults synchronize];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1; // Основные настройки
        case 1: return 2; // Настройки сообщений
        case 2: return 1; // Управление приложениями
        case 3: return 2; // Действия
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Основные настройки";
        case 1: return @"Настройки уведомлений";
        case 2: return @"Управление приложениями";
        case 3: return @"Действия";
        default: return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0: // Основные настройки
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Включить GuDestroyer";
                if (!self.enabledSwitch) {
                    self.enabledSwitch = [[UISwitch alloc] init];
                    self.enabledSwitch.on = [self.defaults boolForKey:@"enabled"];
                    [self.enabledSwitch addTarget:self action:@selector(enabledSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                }
                cell.accessoryView = self.enabledSwitch;
            }
            break;
            
        case 1: // Настройки сообщений
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Заголовок уведомления";
                if (!self.titleField) {
                    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
                    self.titleField.text = [self.defaults stringForKey:@"alertTitle"] ?: @"Приложение заблокировано";
                    self.titleField.placeholder = @"Введите заголовок";
                    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
                }
                cell.accessoryView = self.titleField;
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Текст уведомления";
                if (!self.messageField) {
                    self.messageField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
                    self.messageField.text = [self.defaults stringForKey:@"alertMessage"] ?: @"Это приложение заблокировано GuDestroyer";
                    self.messageField.placeholder = @"Введите текст сообщения";
                    self.messageField.borderStyle = UITextBorderStyleRoundedRect;
                }
                cell.accessoryView = self.messageField;
            }
            break;
            
        case 2: // Управление приложениями
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Выбрать приложения для блокировки";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            break;
            
        case 3: // Действия
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Применить настройки";
                cell.textLabel.textColor = [UIColor systemBlueColor];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Респринг";
                cell.textLabel.textColor = [UIColor systemRedColor];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 2: // Управление приложениями
            if (indexPath.row == 0) {
                [self selectApps];
            }
            break;
            
        case 3: // Действия
            if (indexPath.row == 0) {
                [self applySettings];
            } else if (indexPath.row == 1) {
                [self respring];
            }
            break;
    }
}

- (void)enabledSwitchChanged:(UISwitch *)sender {
    [self.defaults setBool:sender.on forKey:@"enabled"];
    [self.defaults synchronize];
}

- (void)applySettings {
    // Сохраняем настройки
    [self.defaults setObject:self.titleField.text forKey:@"alertTitle"];
    [self.defaults setObject:self.messageField.text forKey:@"alertMessage"];
    [self.defaults synchronize];
    
    // Показываем уведомление об успешном применении
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Настройки применены"
                                                                   message:@"Изменения сохранены и будут применены после респринга"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" 
                                                       style:UIAlertActionStyleDefault 
                                                     handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)respring {
    // Кнопка для респринга
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Респринг"
                                                                   message:@"Перезапустить SpringBoard для применения изменений?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Да" 
                                                        style:UIAlertActionStyleDestructive 
                                                      handler:^(UIAlertAction *action) {
        // Выполняем респринг
        pid_t pid;
        const char* args[] = {"killall", "-9", "SpringBoard", NULL};
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Нет" 
                                                       style:UIAlertActionStyleCancel 
                                                     handler:nil];
    
    [alert addAction:yesAction];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)selectApps {
    // Открываем список приложений для выбора
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Выбор приложений"
                                                                   message:@"Эта функция будет реализована в следующих версиях"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" 
                                                       style:UIAlertActionStyleDefault 
                                                     handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end

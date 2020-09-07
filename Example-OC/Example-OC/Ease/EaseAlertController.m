//
//  EaseAlertController.m
//  Ease
//
//  Created by 洛奇 on 2019/6/4.
//  Copyright © 2019 huayang. All rights reserved.
//

#import "EaseAlertController.h"
//#import <YYKit/UIDevice+YYAdd.h>

static NSString * const kAlertActionSheetHandleDisplayText = @"handleDisplayText";
static NSString * const kAlertActionSheetHandleStyle = @"handleStyle";

@interface EaseAlertAction ()

@property (nonatomic ,copy) NSString * text;
@property (nonatomic ,assign) UIAlertActionStyle style;
@property (nonatomic ,assign) NSInteger index;
@property (nonatomic ,copy) EaseAlertControllerAction click;
@end

@implementation EaseAlertAction

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"EaseAlertAction:%@ dealloc",self.text);
#endif
}

+ (instancetype) cancelAction:(NSString *)title{
    return [self cancelAction:nil title:title];
}
+ (instancetype) cancelAction:(nullable EaseAlertControllerAction)click title:(NSString *)title{
    return [self action:click title:title style:UIAlertActionStyleCancel];
}

+ (instancetype) action:(NSString *)title{
    return [self action:title style:UIAlertActionStyleDefault];
}
+ (instancetype) action:(NSString *)title style:(UIAlertActionStyle)style{
    return [self action:nil title:title style:style];
}
+ (instancetype) action:(nullable EaseAlertControllerAction)click title:(NSString *)title{
    return [self action:click title:title style:UIAlertActionStyleDefault];
}
+ (instancetype) action:(nullable EaseAlertControllerAction)click title:(NSString *)title style:(UIAlertActionStyle)style{
    return [[self alloc] initWithClick:click title:title style:style];
}

- (instancetype)initWithClick:(nullable EaseAlertControllerAction)click title:(NSString *)title style:(UIAlertActionStyle)style{
    self = [super init];
    if (self) {
        _style = style;
        _text = title;
        _click = click;
        _index = 0;
    }
    return self;
}

@end

@interface EaseInternalAlertModel : NSObject{
    NSMutableArray <EaseAlertAction *> * _internalActions;
}

@property (weak, nonatomic) UIAlertController * alertVC;

@property (strong, nonatomic) NSString *title; // 标题
@property (strong, nonatomic) NSString *message; // 内容

@property (nonatomic ,copy) void (^bAction)(NSInteger index);

- (NSArray *)actions;
- (void) addAction:(EaseAlertAction *)action;
- (EaseAlertAction *) actionAtIndex:(NSInteger)index;
@end

@implementation EaseInternalAlertModel

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%@ dealloc",self);
#endif
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _internalActions = [NSMutableArray array];
    }
    return self;
}

- (BOOL) isInvaild:(NSInteger)index{
    
    return _internalActions && _internalActions.count && index < _internalActions.count;
}

- (void) addAction:(EaseAlertAction *)action{
    if (action) {
        [_internalActions addObject:action];
    }
}

- (EaseAlertAction *) actionAtIndex:(NSInteger)index{
    if ([self isInvaild:index]) {
        return [_internalActions objectAtIndex:index];
    }
    return nil;
}

- (NSArray *)actions{
    return _internalActions.copy;
}

@end

@interface EaseInternalAlertController : NSObject<EaseAlertControllerProtocol>{
    UIAlertControllerStyle _style;
}
@property (nonatomic ,strong) EaseInternalAlertModel * aModel;

- (instancetype) initWithSeylt:(UIAlertControllerStyle)style;

@end

@implementation EaseInternalAlertController

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%@ dealloc",self);
#endif
}
- (instancetype) initWithSeylt:(UIAlertControllerStyle)style{

    self = [super init];
    if (self) {
        _style = style;
        self.aModel = [[EaseInternalAlertModel alloc] init];
    }
    return self;
}

- (EaseAlertAble) title:(NSString *)titile{
    self.aModel.title = titile;
    return self;
}

- (EaseAlertAble) message:(NSString *)message{
    self.aModel.message = message;
    return self;
}

- (EaseAlertAble) actionArrayTitles:(NSArray<NSString *> *)titles{
    
    if (titles && titles.count) {
        NSInteger i = 0;
        for (NSString * text in titles) {
            EaseAlertAction * action = [EaseAlertAction new];
            action.text = text;
            action.index = i;
            [self.aModel addAction:action];
            i ++;
        }
    }
    return self;
}

- (EaseAlertAble) actionTitles:(NSString *)actionTitles, ... NS_REQUIRES_NIL_TERMINATION{
    
    if(actionTitles){
        NSMutableArray *titles = [NSMutableArray array];
        va_list args;
        va_start(args, actionTitles);
        for (NSString *str = actionTitles; str != nil; str = va_arg(args,NSString*)) {
            [titles addObject:str];
        }
        va_end(args);
        
        if (titles && titles.count) {
            NSInteger i = 0;
            for (NSString * title in titles) {
                EaseAlertAction * action = [EaseAlertAction new];
                action.text = title;
                action.index = i;
                [self.aModel addAction:action];
                i ++;
            }
        }
    }
    return self;
}

- (EaseAlertAble) style:(UIAlertActionStyle)style index:(NSInteger)index{
    
    NSAssert([self.aModel isInvaild:index], @"Your `handleButtons` MUST BE nunull, AND the `index` less then handleButtons's length.");
    
    EaseAlertAction * action = [self.aModel actionAtIndex:index];
    action.style = style;

    return self;
}
- (EaseAlertAble) addCancelAction:(NSString *)title{
    return [self addCancelAction:nil title:title];
}
- (EaseAlertAble) addCancelAction:(nullable EaseAlertControllerAction)click
                            title:(NSString *)title{
    return [self addAction:click title:title style:UIAlertActionStyleCancel];
}
- (EaseAlertAble) addAction:(nullable EaseAlertControllerAction)click title:(NSString *)title{
    return [self addAction:click title:title style:UIAlertActionStyleDefault];
}
- (EaseAlertAble) addAction:(nullable EaseAlertControllerAction)click title:(NSString *)title style:(UIAlertActionStyle)style{
    EaseAlertAction * action = [EaseAlertAction action:click title:title style:style];
    return [self addAction:action];
}

- (EaseAlertAble) addAction:(EaseAlertAction *)action{
    action.index = self.aModel.actions.count;
    [self.aModel addAction:action];
    return self;
}

- (EaseAlertAble) addActions:(NSArray<EaseAlertAction *> *)actions{
    [actions enumerateObjectsUsingBlock:^(EaseAlertAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addAction:action];
    }];
    return self;
}

- (EaseAlertAble) fetchAction:(void (^)(NSInteger index))bAction{
    
    self.aModel.bAction = bAction;
    return self;
}

- (EaseAlertAble) show{
    return [self showIn:nil];
}

- (EaseAlertAble) showIn:(nullable __kindof UIViewController *)vc{
    
    [self alertController];
    if (vc) {
//        if ([UIDevice currentDevice].isPad &&
//            [self style] == UIAlertControllerStyleActionSheet) {
//            CGFloat width = vc.view.frame.size.width;
//            CGFloat height = vc.view.frame.size.height;
//            self.aModel.alertVC.popoverPresentationController.sourceView = vc.view;
//            self.aModel.alertVC.popoverPresentationController.sourceRect = (CGRect){
//                width * 0.5,
//                height - 50,
//                0,50.0
//            };
//        }
        [vc presentViewController:self.aModel.alertVC animated:YES completion:nil];
    }
    return self;
}
- (UIAlertController *) alertController{
    
    if (self.aModel.alertVC) {
        return self.aModel.alertVC;
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:self.aModel.title message:self.aModel.message preferredStyle:[self style]];
    self.aModel.alertVC = alertVC;
    
    for (int i = 0; i < self.aModel.actions.count; i++) {
        EaseAlertAction * action = [self.aModel actionAtIndex:i];
        
        NSString * title = action.text;
        UIAlertActionStyle style = action.style;
        
        UIAlertAction *ui_action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * ui_internal_action) {
            if (action.click) {
                action.click();
            }
            if (self.aModel.bAction) {
                self.aModel.bAction(i);
            }
        }];
        [self.aModel.alertVC addAction:ui_action];
    }
    return alertVC;
}

- (void)dismiss{
    [self dismiss:nil];
}

- (void) dismiss:(void (^ __nullable)(void))completion{
    [self.aModel.alertVC dismissViewControllerAnimated:YES completion:completion];
}

- (UIAlertControllerStyle) style{
    return _style;
}
@end

@implementation EaseAlertController

#pragma mark - config

+ (EaseAlertAble) alert{
    return [[EaseInternalAlertController alloc] initWithSeylt:UIAlertControllerStyleAlert];
}

+ (EaseAlertAble) actionSheet{
    return [[EaseInternalAlertController alloc] initWithSeylt:UIAlertControllerStyleActionSheet];
}
@end

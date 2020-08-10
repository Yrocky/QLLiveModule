//
//  EaseAlertController.h
//  Ease
//
//  Created by 洛奇 on 2019/6/4.
//  Copyright © 2019 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EaseAlertAction;

@protocol EaseAlertControllerProtocol;

typedef id<EaseAlertControllerProtocol> EaseAlertAble;

typedef void(^EaseAlertControllerAction)(void);

///<使用协议抽象出来alert和actionSheet的共有接口
@protocol EaseAlertControllerProtocol <NSObject>

@optional
#pragma mark - config

- (EaseAlertAble) title:(NSString *)titile;
- (EaseAlertAble) message:(NSString *)message;

/** Default handle button type is `UIAlertActionStyleDefault`. */
- (EaseAlertAble) actionArrayTitles:(NSArray<NSString *> *)actions;
/** Explain some as above .这个采用多字符串的方式传递buttons，以应对button-fetch不对应的问题*/
- (EaseAlertAble) actionTitles:(NSString *)actionTitles, ... NS_REQUIRES_NIL_TERMINATION;

/** Config special button type at `index`. */
- (EaseAlertAble) style:(UIAlertActionStyle)style index:(NSInteger)index;

- (EaseAlertAble) addCancelAction:(NSString *)title;
- (EaseAlertAble) addCancelAction:(nullable EaseAlertControllerAction)click
                            title:(NSString *)title;
- (EaseAlertAble) addAction:(nullable EaseAlertControllerAction)click
                      title:(NSString *)title;///<default is UIAlertActionStyleDefault
- (EaseAlertAble) addAction:(nullable EaseAlertControllerAction)click
                      title:(NSString *)title style:(UIAlertActionStyle)style;

- (EaseAlertAble) addAction:(EaseAlertAction *)action;
- (EaseAlertAble) addActions:(NSArray<EaseAlertAction *> *)actions;

- (UIAlertController *) alertController;
@required

#pragma mark - fetch

- (EaseAlertAble) fetchAction:(void (^)(NSInteger index))bAction;

#pragma mark - show

- (EaseAlertAble) show;
- (EaseAlertAble) showIn:(nullable __kindof UIViewController *)vc;

#pragma mark - dismiss

- (void) dismiss;
- (void) dismiss:(void (^ __nullable)(void))completion;
@end

/**
 *  对系统的UIAlertController的简单封装
 */
@interface EaseAlertController : NSObject

+ (EaseAlertAble) alert;

+ (EaseAlertAble) actionSheet;
@end

/**
 *  对系统的UIAlertAction的简单封装
 */
@interface EaseAlertAction : NSObject

+ (instancetype) cancelAction:(NSString *)title;
+ (instancetype) cancelAction:(nullable EaseAlertControllerAction)click title:(NSString *)title;

+ (instancetype) action:(NSString *)title;
+ (instancetype) action:(NSString *)title style:(UIAlertActionStyle)style;
+ (instancetype) action:(nullable EaseAlertControllerAction)click title:(NSString *)title;
+ (instancetype) action:(nullable EaseAlertControllerAction)click title:(NSString *)title style:(UIAlertActionStyle)style;

@end

NS_ASSUME_NONNULL_END

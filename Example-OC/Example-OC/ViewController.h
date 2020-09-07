//
//  ViewController.h
//  Example-OC
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//


#import "DemoCompositeListViewController.h"

@interface ViewController : DemoCompositeListViewController

@end

@interface DemoModule : QLLiveModule
- (void) setupComponents:(NSDictionary *)data;
@end

@interface DemoFlexLayoutModule : DemoModule

@end

@interface DemoListLayoutModule : DemoModule

@end

@interface DemoWaterfallLayoutModule : DemoModule

@end

@interface DemoBackgroundDecorateModule : DemoModule

@end

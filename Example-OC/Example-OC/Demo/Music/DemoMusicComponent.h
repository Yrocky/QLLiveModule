//
//  DemoMusicComponent.h
//  QILievModule
//
//  Created by rocky on 2020/8/25.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <QLLiveModuler/QLLiveModuler.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoMusicComponent : QLLiveComponent

- (instancetype) initWithName:(NSString *)name;
@end

@interface MusicTodayComponent : DemoMusicComponent<
QLLiveFlexLayoutDelegate>

@end

// 1080*420
@interface MusicBannerComponent : QLLiveComponent

@end

@interface MusicWeekRankComponent : DemoMusicComponent

@end

@interface MusicSongListComponent : DemoMusicComponent

@end

@interface MusicSongCardComponent : DemoMusicComponent

@end
NS_ASSUME_NONNULL_END
